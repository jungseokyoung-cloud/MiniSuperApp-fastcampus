//
//  BaseURL.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/22.
//

import Foundation

struct BaseURL {
    var financeBaseURL: URL {
        return URL(string: "https://finance.superapp.com/api/v1")!
    }
}
