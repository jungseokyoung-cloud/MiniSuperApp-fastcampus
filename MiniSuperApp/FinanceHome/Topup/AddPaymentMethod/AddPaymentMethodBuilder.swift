//
//  AddPaymentMethodBuilder.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import ModernRIBs

protocol AddPaymentMethodDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepositry { get }
}

final class AddPaymentMethodComponent: Component<AddPaymentMethodDependency>, AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositry { dependency.cardOnFileRepository }
}

// MARK: - Builder

protocol AddPaymentMethodBuildable: Buildable {
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> AddPaymentMethodRouting
}

final class AddPaymentMethodBuilder: Builder<AddPaymentMethodDependency>, AddPaymentMethodBuildable {

    override init(dependency: AddPaymentMethodDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> AddPaymentMethodRouting {
        let component = AddPaymentMethodComponent(dependency: dependency)
        let viewController = AddPaymentMethodViewController(closeButtonType: closeButtonType)
        let interactor = AddPaymentMethodInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return AddPaymentMethodRouter(interactor: interactor, viewController: viewController)
    }
}
