//
//  TransportHomeInterface.swift
//  
//
//  Created by Seok Young Jung on 2023/04/21.
//

import ModernRIBs


public protocol TransportHomeBuildable: Buildable {
    func build(withListener listener: TransportHomeListener) -> ViewableRouting
}

public protocol TransportHomeListener: AnyObject {
    func transportHomeDidTapClose()
}

