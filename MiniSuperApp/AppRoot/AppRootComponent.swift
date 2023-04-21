//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/21.
//

import ModernRIBs
import TransportHome
import TransportHomeImp
import AddPaymentMethod
import AddPaymentMethodImp
import Topup
import TopupImp
import FinanceHome
import ProfileHome
import AppHome
import FinanceRepository
import RIBsUtil


final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency  {
    
    
    var cardOnFileRepository: CardOnFileRepositry
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()
    
    lazy var topupBuildable: TopupBuildable = {
        return TopupBuilder(dependency: self)
    }()
    
    lazy var addPaymentMethodBuildable: AddPaymentMethodBuildable = {
        return AddPaymentMethodBuilder(dependency: self)
    }()
    
    var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }

    private let rootViewController: ViewControllable
    
    init(
        dependency: AppRootDependency,
        cardOnFileRepository: CardOnFileRepositry,
        superPayRepository: SuperPayRepository,
        rootViewController: ViewControllable
    ) {
        self.cardOnFileRepository = cardOnFileRepository
        self.superPayRepository = superPayRepository
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
