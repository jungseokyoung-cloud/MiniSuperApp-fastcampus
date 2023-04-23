//
//  TopupInteractorTests.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/24.
//

@testable import TopupImp
import XCTest
import TopupTestSupport

final class TopupInteractorTests: XCTestCase {

    private var sut: TopupInteractor!
    private var dependency: TopupDependencyMock!
    private var listener: TopupListenerMock!

    override func setUp() {
        super.setUp()
        
        self.dependency = TopupDependencyMock()
        self.listener = TopupListenerMock()
        
        sut = TopupInteractor(dependency: self.dependency)
        sut.listener = self.listener
        sut.router = 
    }

    // MARK: - Tests

    func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
        // This is an example of an interactor test case.
        // Test your interactor binds observables and sends messages to router or listener.
    }
}
