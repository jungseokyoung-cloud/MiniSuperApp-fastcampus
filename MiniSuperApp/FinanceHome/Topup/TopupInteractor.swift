//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/17.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositry { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdativePresentationControllerDelegate {

    weak var router: TopupRouting?
    weak var listener: TopupListener?
    
    let presentationDelegateProxy: AdativePresentationControllerDelegateProxy

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
        
        if dependency.cardOnFileRepository.cardOnFile.value.isEmpty {
            router?.attachAddPaymentMethod()
        } else {
            // 금액 입력화면
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
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidAddCard(payment: PaymentMethod) {
        
    }

}
