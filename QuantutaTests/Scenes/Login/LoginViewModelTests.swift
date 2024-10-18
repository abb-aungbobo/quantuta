//
//  LoginViewModelTests.swift
//  QuantutaTests
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Auth
import XCTest

final class LoginViewModelTests: XCTestCase {
    private var sut: LoginViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let authRepository: AuthRepository = AuthRepositoryStub()
        sut = LoginViewModel(authRepository: authRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenLogin_shouldBeIdleAndLoadingAndSucceeded() async {
        let expected: [LoginViewModel.State] = [.idle, .loading, .succeeded]
        var results: [LoginViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.login(login: "username", password: "password")
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_isValidLoginAndPassword_withValidLoginAndInvalidPassword_shouldBeFalse() {
        let login: String? = "user@email.com"
        let password: String? = nil
        XCTAssertFalse(sut.isValid(login: login, password: password))
    }
    
    func test_isValidLoginAndPassword_withInvalidLoginAndValidPassword_shouldBeFalse() {
        let login: String? = nil
        let password: String? = "password"
        XCTAssertFalse(sut.isValid(login: login, password: password))
    }
    
    func test_isValidLoginAndPassword_withInvalidLoginAndInvalidPassword_shouldBeFalse() {
        let login: String? = ""
        let password: String? = ""
        XCTAssertFalse(sut.isValid(login: login, password: password))
    }
    
    func test_isValidLoginAndPassword_withValidLoginAndValidPassword_shouldBeTrue() {
        let login: String? = "username"
        let password: String? = "password"
        XCTAssertTrue(sut.isValid(login: login, password: password))
    }
}
