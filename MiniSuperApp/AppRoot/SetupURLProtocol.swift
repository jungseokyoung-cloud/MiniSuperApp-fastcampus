//
//  SetupURLProtocol.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/22.
//

import Foundation

func setupURLProtocol() {
    // Topup
    let topupResponse: [String: Any] = [
        "status": "success"
    ]
    
    let topupResponseData = try! JSONSerialization.data(withJSONObject: topupResponse, options: [])
    
    
    //AddCard
    let addCardResponse: [String: Any] = [
        "card": [
            "id": "999",
            "name": "새 카드",
            "digits": "**** 0101",
            "color": "",
            "isPrimary": false
        ]
    ]
    
    let addCardResponseData = try! JSONSerialization.data(withJSONObject: addCardResponse, options: [])
    
    
    //CardOnFile
    let cardOnFileResponse: [String: Any] = [
        "cards": [
            [
                "id": "0",
                "name": "카카오 뱅크",
                "digits": "9899",
                "color": "#65c466ff",
                "isPrimary": false
            ],
            [
                "id": "1",
                "name": "우리은행",
                "digits": "2432",
                "color": "#78c5f5ff",
                "isPrimary": false
            ],
            [
                "id": "2",
                "name": "신한은행",
                "digits": "3543",
                "color": "#ffcc00ff",
                "isPrimary": false
            ]
        ]
    ]
    
    let cardOnFileResponseData = try! JSONSerialization.data(withJSONObject: cardOnFileResponse, options: [])
    
    SuperAppURLProtocol.successMock = [
        "/api/v1/topup": (200, topupResponseData),
        "/api/v1/addCard": (200, addCardResponseData),
        "/api/v1/cards": (200, cardOnFileResponseData),
    ]
}
