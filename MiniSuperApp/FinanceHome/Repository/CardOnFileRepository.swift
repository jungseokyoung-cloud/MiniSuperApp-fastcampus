//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import Foundation

protocol CardOnFileRepositry {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepositry {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "1234", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "카카오 뱅크", digits: "9899", color: "#3478f6ff", isPrimary: false),
        PaymentMethod(id: "2", name: "신한은행", digits: "2432", color: "#78c5f5ff", isPrimary: false),
        PaymentMethod(id: "3", name: "국민은행", digits: "3333", color: "#65c466ff", isPrimary: false),
        PaymentMethod(id: "4", name: "우리은행", digits: "3543", color: "#ffcc00ff", isPrimary: false),
    ])
    
}
