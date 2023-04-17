//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/17.
//

import ModernRIBs

protocol TopupInteractable: Interactable, AddPaymentMethodListener {
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
    var presentationDelegateProxy: AdativePresentationControllerDelegateProxy { get }
}

protocol TopupViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    
    private var navigationControllable: NavigationControllerable?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?

    init(
        interactor: TopupInteractable,
        viewController: ViewControllable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        if viewController.uiviewController.presentedViewController != nil,
            navigationControllable != nil {
            navigationControllable?.dismiss(completion: nil)
        }
    }
    
    func attachAddPaymentMethod() {
        if addPaymentMethodRouting != nil { return }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        
        presentInsideNavagivation(router.viewControllable)
        attachChild(router)
        addPaymentMethodRouting = router
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else { return }
        
        dismissPresentedNavigation(completion: nil)
        detachChild(router)
        addPaymentMethodRouting = nil
    }
    
    private func presentInsideNavagivation(_ viewControllable: ViewControllable) {
        let navigation = NavigationControllerable(root: viewControllable)
        self.navigationControllable = navigation
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        viewController.present(navigation, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        if self.navigationControllable == nil { return }
        
        viewController.dismiss(completion: nil)
        self.navigationControllable = nil
    }

    // MARK: - Private

    private let viewController: ViewControllable
}
