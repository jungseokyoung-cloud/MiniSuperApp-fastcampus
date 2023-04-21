//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/21.
//

import ModernRIBs
import FinanceHome
import ProfileHome
import AppHome
import FinanceRepository
import TransportHome
import TransportHomeImp

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency  {
    
    var cardOnFileRepository: CardOnFileRepositry
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()

    init(
        dependency: AppRootDependency,
        cardOnFileRepository: CardOnFileRepositry,
        superPayRepository: SuperPayRepository
    ) {
        self.cardOnFileRepository = cardOnFileRepository
        self.superPayRepository = superPayRepository
        super.init(dependency: dependency)
    }
}
