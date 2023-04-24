//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/24.
//

import Foundation
import FinanceRepository
import CombineUtil
import FinanceEntity
import Combine

public final class CardOnFileRepositoryMock : CardOnFileRepositry {
    
    public var cardOnFileSubject: CurrentValuePublisher<[PaymentMethod]> = .init([])
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { cardOnFileSubject }
    
    public var addCardCallCount = 0
    public var addCardInfo: AddPaymentMethodInfo?
    public var addPaymentMethod: PaymentMethod?
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        addCardCallCount += 1
        addCardInfo = info
        
        if let addPaymentMethod = addPaymentMethod {
            return Just(addPaymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "CardOnFileRepositoryMock", code: 0)).eraseToAnyPublisher()
        }
    }
    
    public var fetchCallCount = 0
    public func fetch() {
        fetchCallCount += 1
    }
    
    public init() { }
}
