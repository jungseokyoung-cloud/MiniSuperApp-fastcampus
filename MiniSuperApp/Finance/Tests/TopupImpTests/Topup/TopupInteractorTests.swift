//
//  TopupInteractorTests.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/24.
//

@testable import TopupImp
import XCTest
import TopupTestSupport
import FinanceRepositoryTestSupport
import FinanceEntity

final class TopupInteractorTests: XCTestCase {
    
    private var sut: TopupInteractor!
    private var dependency: TopupDependencyMock!
    private var listener: TopupListenerMock!
    private var router: TopupRoutingMock!
    
    private var cardOnFileRepository: CardOnFileRepositoryMock {
        dependency.cardOnFileRepository as! CardOnFileRepositoryMock
    }
    
    override func setUp() {
        super.setUp()
        
        self.dependency = TopupDependencyMock()
        self.listener = TopupListenerMock()
        
        let interactor = TopupInteractor(dependency: self.dependency)
        self.router = TopupRoutingMock(interactable: interactor)
        
        interactor.listener = self.listener
        interactor.router = self.router
        self.sut = interactor
    }
    
    // MARK: - Tests
    
    func testActivate() {
        // given
        let cards = [
            PaymentMethod(
                id: "0",
                name: "Zero",
                digits: "0123",
                color: "",
                isPrimary: false
            )
        ]
        
        cardOnFileRepository.cardOnFileSubject.send(cards)
        
        //when
        sut.activate()
        
        // then
        XCTAssertEqual(router.attachEnterAmountCallCount, 1)
        XCTAssertEqual(dependency.paymentMethodStream.value.name, "Zero")
    }
    
    func testActivateWithoutCard() {
        // given
        cardOnFileRepository.cardOnFileSubject.send([])
        
        //when
        sut.activate()
        
        // then
        XCTAssertEqual(router.attachAddPaymentMethodCallCount, 1)
        XCTAssertEqual(router.attachAddPaymentMethodCloseButtonType, .close)
    }
    
    func testDidAddCardWithCard() {
        // given
        let cards = [
            PaymentMethod(
                id: "0",
                name: "Zero",
                digits: "0123",
                color: "",
                isPrimary: false
            )
        ]
        cardOnFileRepository.cardOnFileSubject.send(cards)
        //EnterAmountRoot == true이기에, popToRoot호출됨
        
        let newCard = PaymentMethod(
            id: "new_card_id",
            name: "New_Card",
            digits: "0000",
            color: "",
            isPrimary: false)
        
        // when
        sut.activate()
        sut.addPaymentMethodDidAddCard(payment: newCard)
        
        // then
        XCTAssertEqual(router.popToRootCallCount, 1)
        XCTAssertEqual(dependency.paymentMethodStream.value.id, "new_card_id")
    }
    
    func testDidAddCardWithoutCard() {
        // given
        cardOnFileRepository.cardOnFileSubject.send([])
        //EnterAmountRoot == true이기에, popToRoot호출됨
        
        let newCard = PaymentMethod(
            id: "new_card_id",
            name: "New_Card",
            digits: "0000",
            color: "",
            isPrimary: false)
        
        // when
        sut.activate()
        sut.addPaymentMethodDidAddCard(payment: newCard)
        
        // then
        XCTAssertEqual(router.attachEnterAmountCallCount, 1)
        XCTAssertEqual(dependency.paymentMethodStream.value.id, "new_card_id")
    }
    
    func testAddPaymentMethodDidTapCloseFromEnterAmount() {
        // given
        let cards = [
            PaymentMethod(
                id: "0",
                name: "Zero",
                digits: "0123",
                color: "",
                isPrimary: false
            )
        ]
        cardOnFileRepository.cardOnFileSubject.send(cards)
        
        // when
        sut.activate()
        sut.addPaymentMethodDidTapClose()
        
        // then
        XCTAssertEqual(router.detachAddPaymentMethodCallCount, 1)
    }
    
    func testAddPaymentMethodDidTapClose() {
        // given
        cardOnFileRepository.cardOnFileSubject.send([])
        
        // when
        sut.activate()
        sut.addPaymentMethodDidTapClose()
        
        // then
        XCTAssertEqual(router.detachAddPaymentMethodCallCount, 1)
        XCTAssertEqual(listener.topupDidCloseCallCount, 1)
    }
    
    func testDidSelectCard() {
        // given
        let cards = [
            PaymentMethod(
                id: "0",
                name: "Zero",
                digits: "0123",
                color: "",
                isPrimary: false
            ),
            PaymentMethod(
                id: "1",
                name: "One",
                digits: "0000",
                color: "",
                isPrimary: false)
        ]
        
        cardOnFileRepository.cardOnFileSubject.send(cards)
        
        // when
        sut.cardOnFileDidSeletItem(at: 0)
        
        // then
        XCTAssertEqual(dependency.paymentMethodStream.value.id, "0")
        XCTAssertEqual(router.detachCardOnFileCallCount, 1)
    }
    
    func testDidSelectCardWithInvalidIndex() {
        // given
        let cards = [
            PaymentMethod(
                id: "0",
                name: "Zero",
                digits: "0123",
                color: "",
                isPrimary: false
            ),
            PaymentMethod(
                id: "1",
                name: "One",
                digits: "0000",
                color: "",
                isPrimary: false)
        ]
        
        cardOnFileRepository.cardOnFileSubject.send(cards)
        
        // when
        sut.cardOnFileDidSeletItem(at: 2)
        
        // then
        XCTAssertEqual(dependency.paymentMethodStream.value.id, "")
        XCTAssertEqual(router.detachCardOnFileCallCount, 1)
    }
}
