//
//  File.swift
//  
//
//  Created by Seok Young Jung on 2023/04/21.
//

import ModernRIBs

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public protocol TopupListener: AnyObject {
    func topupDidClose()
    func topupFinish()
}
