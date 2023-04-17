//
//  CardOnFileInteractor.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/17.
//

import ModernRIBs

protocol CardOnFileRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFilePresentable: Presentable {
    var listener: CardOnFilePresentableListener? { get set }
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileListener: AnyObject {
    func cardOnFileDidTapClose()
    func cardOnFileDidSeletItem(at index: Int)
    func cardOnFileDidTapAddCard()
}

final class CardOnFileInteractor: PresentableInteractor<CardOnFilePresentable>, CardOnFileInteractable, CardOnFilePresentableListener {

    weak var router: CardOnFileRouting?
    weak var listener: CardOnFileListener?

    private var paymentMethods: [PaymentMethod]
    
    init(
        presenter: CardOnFilePresentable,
        paymentMethods: [PaymentMethod]
    ) {
        self.paymentMethods = paymentMethods
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let paymentMethodViewModels = paymentMethods.map(PaymentMethodViewModel.init)
        presenter.update(with: paymentMethodViewModels)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapClose() {
        listener?.cardOnFileDidTapClose()
    }
    
    func didSelectItem(at index: Int) {
        if index < paymentMethods.count {
            listener?.cardOnFileDidSeletItem(at: index)
        } else {
            listener?.cardOnFileDidTapAddCard()
        }
    }
}
