//
//  AdativePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import UIKit

public protocol AdativePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

public final class AdativePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    public weak var delegate: AdativePresentationControllerDelegate?
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
