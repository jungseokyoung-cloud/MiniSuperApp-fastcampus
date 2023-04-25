//
//  CardOnFileInteractorTests.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/25.
//

@testable import TopupImp
import FinanceEntity
import XCTest

final class CardOnFileInteractorTests: XCTestCase {
    
    private var sut: CardOnFileInteractor!
    private var presenter: CardOnFilePresnterMock!
    private var listener: CardOnFileListenerMock!
    
    private var paymentMethods: [PaymentMethod]!
    
    override func setUp() {
        super.setUp()
        
        self.presenter = CardOnFilePresnterMock()
        self.listener = CardOnFileListenerMock()
        self.paymentMethods = [
            PaymentMethod(
                id: "0",
                name: "name_0",
                digits: "1111",
                color: "",
                isPrimary: false
            ),
            PaymentMethod(
                id: "1",
                name: "name_1",
                digits: "2222",
                color: "",
                isPrimary: false
            ),
        ]
        
       sut = CardOnFileInteractor(
            presenter: presenter,
            paymentMethods: paymentMethods
        )
        sut.listener = self.listener
    }
    
    // MARK: - Tests
    
    func testActivate() {
        // given
        
        // when
        sut.activate()
        
        // then
        XCTAssertEqual(presenter.updateCallCount, 1)
        XCTAssertEqual(presenter.seletedViewModels?.first?.name, "name_0")
    }
    
    func testDidTapClose() {
        // given
        
        // when
        sut.didTapClose()
        
        // then
        XCTAssertEqual(listener.cardOnFileDidTapCloseCallCount, 1)
    }
    
    func testDidSeletedItem() {
        // given
        
        // when
        sut.didSelectItem(at: 1)
        
        // then
        XCTAssertEqual(listener.cardOnFileDidSeletItemCallCount, 1)
        XCTAssertEqual(listener.selectedIndex, 1)
    }
    
    func testDidSeletedItemAddCard() {
        // given
        
        // when
        sut.didSelectItem(at: 2)
        
        // then
        XCTAssertEqual(listener.cardOnFileDidTapAddCardCallCount, 1)
    }
}
