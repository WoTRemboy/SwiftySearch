//
//  MainViewModel.swift
//  SwiftySearch
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published internal var currentNumber: Float = 0
    @Published internal var currentLevel = 1
    @Published internal var remainingChecks = 10
    @Published internal var score = 0
    
    @Published internal var bounds: (min: Float, max: Float) = (0, 100)
    @Published internal var result: ResultType = .none
    
    private var targetNumber = Int.random(in: 0...100)
    
    internal var stringNumber: String {
        String(Int(currentNumber))
    }
    
    internal var stringBounds: (min: String, max: String) {
        (String(Int(bounds.min)), String(Int(bounds.max)))
    }
    
    internal var checks: Int {
        (11 - currentLevel) - remainingChecks
    }
    
    internal func cutOffGap(current: Float) {
        remainingChecks -= 1
        withAnimation {
            if Int(current) < targetNumber {
                bounds.min = current
            } else if Int(current) > targetNumber {
                bounds.max = current
            } else {
                result = .success
                score += remainingChecks * 100
            }
            print(targetNumber)
        }
    }
    
    internal func nextLevel() {
        withAnimation {
            remainingChecks = 10 - currentLevel
            bounds = (0, Float(100 - currentLevel * 10))
            currentLevel += 1
            currentNumber = 0
        }
        targetNumber = Int.random(in: 0...(110 - currentLevel * 10))
        result = .none
    }
}
