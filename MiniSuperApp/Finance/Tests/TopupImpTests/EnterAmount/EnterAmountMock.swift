//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/23.
//

import Foundation
import CombineSchedulers
import FinanceEntity
import CombineUtil
import FinanceRepository
import FinanceRepositoryTestSupport
import RIBsTestSupport
@testable import TopupImp

final class EnterAmountPresentableMock: EnterAmountPresentable {
    
    var listener: EnterAmountPresentableListener?
    
    var updateSelectPaymentMethodCallCount = 0
    var updateSelectPaymentMethodViewModel: SelectedPaymentMethodViewModel?
    func updateSelectedPaymentMethod(with viewModel: SelectedPaymentMethodViewModel) {
        updateSelectPaymentMethodCallCount += 1
        updateSelectPaymentMethodViewModel = viewModel
    }
    
    var startLoadingCallCount = 0
    func startLoading() {
        startLoadingCallCount += 1
    }
    
    var stopLoadingCallCount = 0
    func stopLoading() {
        stopLoadingCallCount += 1
    }
    
    init() {
        
    }
}

final class EnterAmountDependencyMock: EnterAmountInteractorDependency {
    var mainQueue: AnySchedulerOf<DispatchQueue> { .immediate }
    
    // Send를 할 수 있는 Publisher
    var selectedPaymentMethodSubject = CurrentValuePublisher<PaymentMethod>(
        PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false)
    )
    
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { selectedPaymentMethodSubject }
    var superPayRepository: SuperPayRepository = SuperPayRepositoryMock()
}

final class EnterAmountListenerMock: EnterAmountListener {
    
    var enterAmountDidTapCloseCallCount = 0
    func enterAmountDidTapClose() {
        enterAmountDidTapCloseCallCount  += 1
    }
    
    var enterAmountDidTapPaymentMethodCallCount = 0
    func enterAmountDidTapPaymentMethod() {
        enterAmountDidTapPaymentMethodCallCount += 1
    }
    
    var enterAmountDidFinishTopupCallCount = 0
    func enterAmountDidFinishTopup() {
        enterAmountDidFinishTopupCallCount += 1
    }
}

final class EnterAmountBuildableMock: EnterAmountBuildable {
    
    var buildHandler: ((_ listener: EnterAmountListener) -> EnterAmountRouting)?
    
    var buildCallCount = 0
    
    func build(withListener listener: EnterAmountListener) -> EnterAmountRouting {
        buildCallCount += 1
        
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        
        fatalError()
    }
}

final class EnterAmountRoutingMock: ViewableRoutingMock, EnterAmountRouting {
    
}
