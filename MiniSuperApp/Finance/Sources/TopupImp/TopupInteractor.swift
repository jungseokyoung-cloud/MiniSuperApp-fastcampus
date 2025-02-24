//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/17.
//

import ModernRIBs
import AddPaymentMethod
import Topup
import FinanceEntity
import FinanceRepository
import RIBsUtil
import CombineUtil
import SuperUI


protocol TopupRouting: Routing {
    func cleanupViews()
    
    func attachAddPaymentMethod(closeButtonType: DismissButtonType)
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
    func popToRoot()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositry { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdativePresentationControllerDelegate {

    weak var router: TopupRouting?
    weak var listener: TopupListener?
    
    let presentationDelegateProxy: AdativePresentationControllerDelegateProxy
    
    private var isEnterAmountRoot: Bool = false
    
    private var paymentMethods: [PaymentMethod] { dependency.cardOnFileRepository.cardOnFile.value }

    private let dependency: TopupInteractorDependency

    init(
        dependency: TopupInteractorDependency
    ) {
        self.presentationDelegateProxy = AdativePresentationControllerDelegateProxy()
        self.dependency = dependency
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let card = dependency.cardOnFileRepository.cardOnFile.value.first {
            isEnterAmountRoot = true
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        } else {
            isEnterAmountRoot = false
            router?.attachAddPaymentMethod(closeButtonType: .close)
        }
    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
    }
    
    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        
        if isEnterAmountRoot == false {
            listener?.topupDidClose()
        }
    }
    
    func addPaymentMethodDidAddCard(payment: PaymentMethod) {
        dependency.paymentMethodStream.send(payment)
        
        if isEnterAmountRoot {
            router?.popToRoot()
        } else {
            isEnterAmountRoot = true
            router?.attachEnterAmount()
        }
    }
    
    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        
        if isEnterAmountRoot == false {
            listener?.topupDidClose()
        }
        
        listener?.topupDidClose()
    }
    
    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: paymentMethods)
    }
    
    func enterAmountDidFinishTopup() {
        listener?.topupFinish()
    }
    
    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }
    
    func cardOnFileDidSeletItem(at index: Int) {
        if let selelcted = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(selelcted)
        }
        router?.detachCardOnFile()
    }
    
    func cardOnFileDidTapAddCard() {
        router?.attachAddPaymentMethod(closeButtonType: .back)
    }
}
