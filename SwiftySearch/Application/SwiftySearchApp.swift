//
//  SwiftySearchApp.swift
//  SwiftySearch
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI

@main
struct SwiftySearchApp: App {
    var body: some Scene {
        WindowGroup {
            let environmentObject = MainViewModel()
            MainView()
                .environmentObject(environmentObject)
        }
    }
}
