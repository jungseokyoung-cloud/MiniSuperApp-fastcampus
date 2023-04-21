//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/22.
//

import ModernRIBs
import RIBsUtil
import FinanceEntity


public protocol AddPaymentMethodBuildable: Buildable {
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting
}

public protocol AddPaymentMethodListener: AnyObject {
    func addPaymentMethodDidTapClose()
    func addPaymentMethodDidAddCard(payment: PaymentMethod)
}
