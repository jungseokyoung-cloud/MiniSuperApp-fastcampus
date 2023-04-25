//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/21.
//

import UIKit
import ModernRIBs
import CombineSchedulers
import TransportHome
import TransportHomeImp
import AddPaymentMethod
import AddPaymentMethodImp
import Topup
import TopupImp
import Network
import NetworkImp
import FinanceHome
import ProfileHome
import AppHome
import FinanceRepository
import RIBsUtil


final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency  {
    
    var cardOnFileRepository: CardOnFileRepositry
    var superPayRepository: SuperPayRepository
    var mainQueue: AnySchedulerOf<DispatchQueue> { .main }
    
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
        rootViewController: ViewControllable
    ) {
        #if UITESTING
        let config = URLSessionConfiguration.default
        #else
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [SuperAppURLProtocol.self]
        setupURLProtocol()
        #endif
   
        
        let network = NetworkImp(session: URLSession(configuration: config))
        
        self.cardOnFileRepository = CardOnFileRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
        self.cardOnFileRepository.fetch()
        
        self.superPayRepository = SuperPayRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
