//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import Foundation
import Combine
import FinanceEntity
import CombineUtil
import Network

public protocol CardOnFileRepositry {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
    func fetch()
}

public final class CardOnFileRepositoryImp: CardOnFileRepositry {
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([])
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let request = AddCardRequest(baseURL: baseURL, info: info)
        
        return network.send(request)
            .map(\.output.card)
            .handleEvents(
                receiveOutput: { [weak self] method in
                    guard let this = self else { return }
                    this.paymentMethodsSubject.send(this.paymentMethodsSubject.value + [method])
                }
            )
            .eraseToAnyPublisher()
    }
    
    public func fetch() {
        let request = CardOnFileReqeust(baseURL: baseURL)
        network.send(request)
            .map(\.output.cards)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] cards in
                    self?.paymentMethodsSubject.send(cards)
                }
            ).store(in: &cancellables)
    }
         
    private let network: Network
    private let baseURL: URL
    private var cancellables: Set<AnyCancellable>
    
    public init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
        self.cancellables = .init()
    }
}
