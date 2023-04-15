//
//  PaymentModel.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
