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
    @Published internal var score = 0
    
    @Published internal var remainingChecks = 10
    @Published internal var remainingDonateChecks = 0
    
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
    
    internal var remainingChecksString: String {
        if remainingDonateChecks == 0 {
            "\(Texts.MainPage.remaining): \(remainingChecks)"
        } else {
            "\(Texts.MainPage.remaining): \(remainingChecks) (\(remainingDonateChecks))"
        }
    }
    
    internal func cutOffGap(current: Float) {
        if remainingChecks == 0 && remainingDonateChecks != 0 {
            remainingDonateChecks -= 1
        } else {
            remainingChecks -= 1

        }
        
        if remainingChecks == 0 && remainingDonateChecks == 0 {
            if Int(current) == targetNumber {
                result = .success
                score += remainingChecks > 0 ? remainingChecks * 100 + 100 : remainingDonateChecks * 100 + 100
            } else {
                result = .failure
            }
        } else {
            withAnimation {
                if Int(current) < targetNumber {
                    bounds.min = current
                } else if Int(current) > targetNumber {
                    bounds.max = current
                } else {
                    result = .success
                    score += remainingChecks > 0 ? remainingChecks * 100 + 100 : remainingDonateChecks * 100 + 100
                }
                print(targetNumber)
            }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.result = .none
        }
        print(targetNumber)
    }
    
    internal func restart() {
        withAnimation {
            remainingChecks = 10
            bounds = (0, 100)
            currentLevel = 1
            currentNumber = 0
            score = 0
        }
        targetNumber = Int.random(in: 0...100)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.result = .none
        }
    }
    
    internal func buyChecks() {
        remainingDonateChecks += 5
        result = .none
    }
}
