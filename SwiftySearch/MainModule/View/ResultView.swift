//
//  ResultView.swift
//  SwiftySearch
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    
    internal var body: some View {
        VStack(spacing: 16) {
            image
            content
            levelButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 320)
        
        .background(Color.BackColors.backSecondary)
        .clipShape(.rect(cornerRadius: 30))
        
        .padding(.horizontal)
    }
    
    private var image: some View {
        Image.ResultsPage.success
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .clipShape(.buttonBorder)
            .padding(.top)
    }
    
    private var content: some View {
        VStack(spacing: 10) {
            Text(Texts.MainPage.ResultPage.completed)
                .font(.segmentTitle())
            
            HStack(spacing: 40) {
                Text("\(Texts.MainPage.ResultPage.score): \(viewModel.score)")
                Text("\(Texts.MainPage.ResultPage.checks): \(viewModel.checks)")
            }
        }
    }
    
    private var levelButton: some View {
        Button {
            
        } label: {
            Text(Texts.MainPage.ResultPage.next)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(Color.green)
        .tint(Color.green)
        .buttonStyle(.bordered)
        
        .padding(.horizontal)
        .padding(.vertical)
    }
}

#Preview {
    let environmentObject = MainViewModel()
    return ResultView()
        .environmentObject(environmentObject)
}
