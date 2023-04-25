//
//  TopupImpUITest.swift
//  MiniSuperAppUITests
//
//  Created by Seok Young Jung on 2023/04/25.
//

import XCTest
import Swifter

final class TopupImpUITest: XCTestCase {
    
    private var app: XCUIApplication!
    private var server: HttpServer!

    override func setUpWithError() throws {
        continueAfterFailure = false

        self.server = HttpServer()
        
        self.app = XCUIApplication()
    }

    func testTopupSuccess() throws {
        //giben
        let cardOnFileJSONPath = try TestUtil.path(for: "cardOnFile.json", in: type(of: self))
        server["/cards"] = shareFile(cardOnFileJSONPath)

        let topupResponseJSONPath = try TestUtil.path(for: "topupSuccessResponse.json", in: type(of: self))
        server["/topup"] = shareFile(topupResponseJSONPath)

        // when
        try server.start()
        app.launch()
        
        // then
        app.tabBars.buttons["superpay_home_tab_bar_item"].tap()
        app.buttons["superpay_dashboard_topup_button"].tap()
        
        let textField = app.textFields["topup_enteramount_textfield"]
//        textField.tap()
//        textField.typeText("10000")
    }
}
