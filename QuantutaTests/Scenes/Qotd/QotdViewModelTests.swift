//
//  QotdViewModelTests.swift
//  QuantutaTests
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Auth
import Core
import Quotes
import XCTest

final class QotdViewModelTests: XCTestCase {
    private var sut: QotdViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let quoteRepository: QuoteRepository = QuoteRepositoryStub()
        let authRepository: CoreAuthRepository = AuthRepositoryStub()
        sut = QotdViewModel(quoteRepository: quoteRepository, authRepository: authRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenGetQotd_shouldBeIdleAndLoadingAndSucceeded() async {
        let expected: [QotdViewModel.State] = [.idle, .loading, .succeeded]
        var results: [QotdViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.getQotd()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenLogout_shouldBeIdleAndLoadingAndLoggedout() async {
        let expected: [QotdViewModel.State] = [.idle, .loading, .loggedout]
        var results: [QotdViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.logout()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_qotd_whenGetQotd_shouldNotBeNil() async {
        await sut.getQotd()
        XCTAssertNotNil(sut.qotd)
    }
}
