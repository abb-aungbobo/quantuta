//
//  QotdViewModel.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Combine
import Core

final public class QotdViewModel {
    public enum State: Equatable {
        case idle
        case loading
        case failed(AppError)
        case succeeded
        case loggedout
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            case (.loggedout, .loggedout): return true
            default: return false
            }
        }
    }
    
    let title = "Quantuta"
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    public private(set) var qotd: Quote? = nil
    
    private let quoteRepository: QuoteRepository
    private let authRepository: CoreAuthRepository
    
    public init(quoteRepository: QuoteRepository, authRepository: CoreAuthRepository) {
        self.quoteRepository = quoteRepository
        self.authRepository = authRepository
    }
    
    @MainActor
    public func getQotd() async {
        state.send(.loading)
        do {
            let result = try await quoteRepository.getQuoteOfTheDay()
            qotd = result.quote
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    @MainActor
    public func logout() async {
        state.send(.loading)
        do {
            let _ = try await authRepository.logout()
            try SecureStorage.shared.removeAll()
            state.send(.loggedout)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
