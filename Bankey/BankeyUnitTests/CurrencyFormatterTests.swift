//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by ibrahim AKPINAR on 12.08.2022.
//

import Foundation
import XCTest
@testable import Bankey


final class Test: XCTestCase {
    var formatter: CurrencyFormatter!
  
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() {
        let result = formatter.dollarsFormatted(929466)
        XCTAssertEqual(result, "$929,466.00")
    }
    
    func testZeroDollarsFormatted() {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
    
    func testDollarsFormattedWithCurrencySymbol() {
        // Given
        let local = Locale.current
        let currencySymbol = local.currencySymbol!
        
        //  When
        let result = formatter.dollarsFormatted(929466.23)
        
        // Then
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
    }
}
