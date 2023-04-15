//
//  AdativePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import UIKit

protocol AdativePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

final class AdativePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    weak var delegate: AdativePresentationControllerDelegate?
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
