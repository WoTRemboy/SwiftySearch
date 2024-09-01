//
//  Labels.swift
//  SwiftySearch
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import Foundation

final class Texts {
    enum MainPage {
        static let check = "Check"
        static let level = "Level"
        static let score = "Score"
        static let remaining = "Remaining checks"
        
        enum ResultPage {
            static let completed = "Level completed!"
            static let failed = "Level failed!"
            
            static let score = "Score"
            static let checks = "Checks"
            
            static let next = "Next level"
            static let restart = "Restart"
            static let buy = "Buy checks"
            
            static let alertTitle = "Purchase completed"
            static let alertContent = "Try your luck this time"
            static let ok = "OK"
        }
    }
}
