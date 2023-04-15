//
//  NumberFormatter.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
}
