//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/24.
//

import Foundation
import FinanceRepository
import FinanceRepositoryTestSupport
import CombineUtil
import FinanceEntity
@testable import TopupImp

final class TopupDependencyMock: TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositry = CardOnFileRepositoryMock()
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> = .init(
        PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false)
    )
}
