//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/12.
//

import ModernRIBs
import Foundation
import Combine

protocol SuperPayDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashboardPresentable: Presentable {
    var listener: SuperPayDashboardPresentableListener? { get set }
    
    func updateBalance(_ balance: String)
}

protocol SuperPayDashboardListener: AnyObject {
    func superPayDashboardDidTapTopup()
}

protocol SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    var balanceFormatter: NumberFormatter { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {
    
    weak var router: SuperPayDashboardRouting?
    weak var listener: SuperPayDashboardListener?
    
    private let dependency: SuperPayDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: SuperPayDashboardPresentable,
        dependency: SuperPayDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.balance.sink { [weak self] balance in
            self?.dependency.balanceFormatter.string(from: NSNumber(value: balance)).map {
                self?.presenter.updateBalance($0)
            }
        }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func topupButtonDidTap() {
        listener?.superPayDashboardDidTapTopup()
    }
}
