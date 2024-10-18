//
//  LoginViewModel.swift
//
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Combine
import Core

final public class LoginViewModel {
    public enum State: Equatable {
        case idle
        case loading
        case failed(AppError)
        case succeeded
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            default: return false
            }
        }
    }
    
    let title = "Quantuta"
    public let state = CurrentValueSubject<State, Never>(.idle)
    public var cancellables: Set<AnyCancellable> = []
    
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func isValid(login: String?, password: String?) -> Bool {
        guard let login, let password else { return false }
        let isValidLogin = !login.trimmingCharacters(in: .whitespaces).isEmpty
        let isValidPassword = !password.trimmingCharacters(in: .whitespaces).isEmpty
        return isValidLogin && isValidPassword
    }
    
    @MainActor
    public func login(login: String, password: String) async {
        state.send(.loading)
        do {
            let request = LoginRequest(user: UserRequest(login: login, password: password))
            let result = try await authRepository.login(request: request)
            try SecureStorage.shared.set(value: result.userToken, key: .userToken)
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
