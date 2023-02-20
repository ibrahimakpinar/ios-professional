//
//  Account.swift
//  Bankey
//
//  Created by ibrahim AKPINAR on 20.02.2023.
//

import Foundation

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
         Account(
            id: "1",
            type: .Banking,
            name: "Account name",
            amount: 0.0,
            createdDateTime: Date()
        )
    }
}
