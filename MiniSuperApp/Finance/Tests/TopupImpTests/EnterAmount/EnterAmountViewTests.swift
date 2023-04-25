//
//  File.swift
//  
//
//  Created by jung on 2023/04/24.
//

import Foundation
import XCTest
import SnapshotTesting
import FinanceEntity
@testable import TopupImp


final class EnterAmountViewTests: XCTestCase {
    
    func testEnterAmount() {
        // given
        let paymentMethod = PaymentMethod(
            id: "0",
            name: "우리은행",
            digits: "**** 9999",
            color: "#51AF80FF",
            isPrimary: false
        )
        let viewModel = SelectedPaymentMethodViewModel(paymentMethod)
        
        // when
        let sut = EnterAmountViewController()
        sut.updateSelectedPaymentMethod(with: viewModel)
        
        // then
//        isRecording = true
        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }
}
