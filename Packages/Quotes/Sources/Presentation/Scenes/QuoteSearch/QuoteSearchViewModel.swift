//
//  QuoteSearchViewModel.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Combine
import Core
import Foundation

final public class QuoteSearchViewModel {
    public enum State: Equatable {
        case idle
        case failed(AppError)
        case succeeded
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            default: return false
            }
        }
    }
        
    public let filter = PassthroughSubject<String, Never>()
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    public private(set) var quotes: [Quote] = []
    
    private let quoteRepository: QuoteRepository
    
    public init(quoteRepository: QuoteRepository) {
        self.quoteRepository = quoteRepository
        
        bind()
    }
    
    private func bind() {
        filter
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }
                
                let filter = text.trimmingCharacters(in: .whitespaces)
                guard !filter.isEmpty else {
                    self.quotes = []
                    self.state.send(.succeeded)
                    return
                }
                
                Task {
                    await self.searchQuotes(filter: filter)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    public func searchQuotes(filter: String) async {
        do {
            let result = try await quoteRepository.getQuotes(filter: filter)
            quotes = result.quotes.filter({ quote in quote != .noQuotesFound })
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
