//
//  AddPaymentMethodBuilder.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import ModernRIBs
import AddPaymentMethod
import RIBsUtil
import FinanceRepository

public protocol AddPaymentMethodDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepositry { get }
}

final class AddPaymentMethodComponent: Component<AddPaymentMethodDependency>, AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositry { dependency.cardOnFileRepository }
}

// MARK: - Builder

public final class AddPaymentMethodBuilder: Builder<AddPaymentMethodDependency>, AddPaymentMethodBuildable {

    public override init(dependency: AddPaymentMethodDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting {
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
