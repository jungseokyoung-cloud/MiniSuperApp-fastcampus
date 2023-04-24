//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/24.
//

import Foundation
import FinanceEntity
import RIBsTestSupport
@testable import TopupImp

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
