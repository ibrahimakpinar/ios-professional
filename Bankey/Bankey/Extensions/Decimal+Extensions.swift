//
//  Decimal+Extensions.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 11.08.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
