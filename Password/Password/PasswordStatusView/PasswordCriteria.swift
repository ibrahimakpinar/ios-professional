//
//  PasswordCriteria.swift
//  Password
//
//  Created by ibrahim AKPINAR on 4.03.2023.
//

import Foundation

struct PasswordCriteria {
    
    static func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    
    static func noSpaceCriteriaMet(_ text:String) -> Bool {
        text.rangeOfCharacter(from: .whitespaces) == nil
    }
    
    static func lengthAndNoSpaceCriteriaMet(_ text:String) -> Bool {
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    static func upperCaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    static func lowerCaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    static func digitMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    static func specialCharacterMet(_ text: String) -> Bool {
        return text.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil
    }
}
