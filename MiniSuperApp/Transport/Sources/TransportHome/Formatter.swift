//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Seok Young Jung on 2023/04/20.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
}
