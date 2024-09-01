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
    @Published internal var bounds: (min: Float, max: Float) = (0, 100)
    @Published internal var win: Bool = false
    
    private var targetNumber = Int.random(in: 0...100)
    
    internal var stringNumber: String {
        String(Int(currentNumber))
    }
    
    internal var stringBounds: (min: String, max: String) {
        (String(Int(bounds.min)), String(Int(bounds.max)))
    }
    
    internal func cutOffGap() {
        withAnimation {
            if Int(currentLevel) < targetNumber {
                bounds.max = currentNumber
            } else if Int(currentLevel) > targetNumber {
                bounds.min = currentNumber
            } else {
                win = true
            }
            print(targetNumber)
        }
    }
}
