//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/24.
//

@testable import TopupImp
import Foundation
import FinanceEntity
import RIBsTestSupport

final class CardOnFileBuildableMock: CardOnFileBuildable {
    var buildHandler: ((_ listener: CardOnFileListener) -> CardOnFileRouting)?
    
    var buildCallCount = 0
    var buildPaymentMethod: [PaymentMethod]?
    func build(withListener listener: CardOnFileListener, paymentMethods: [PaymentMethod]) -> CardOnFileRouting {
        buildCallCount += 1
        self.buildPaymentMethod = paymentMethods
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class CardOnFileRoutingMock: ViewableRoutingMock, CardOnFileRouting {
}

//MARK: - PresenterMock
final class CardOnFilePresnterMock: CardOnFilePresentable {
    
    var listener: CardOnFilePresentableListener?
    
    var updateCallCount = 0
    var seletedViewModels: [PaymentMethodViewModel]?
    func update(with viewModels: [PaymentMethodViewModel]) {
        updateCallCount += 1
        self.seletedViewModels = viewModels
    }
}

final class CardOnFileListenerMock: CardOnFileListener {
    
    var cardOnFileDidTapCloseCallCount = 0
    func cardOnFileDidTapClose() {
        cardOnFileDidTapCloseCallCount += 1
    }
    
    var cardOnFileDidSeletItemCallCount = 0
    var selectedIndex: Int?
    func cardOnFileDidSeletItem(at index: Int) {
        cardOnFileDidSeletItemCallCount += 1
        selectedIndex = index
    }
    
    var cardOnFileDidTapAddCardCallCount = 0
    func cardOnFileDidTapAddCard() {
        cardOnFileDidTapAddCardCallCount += 1
    }
}
