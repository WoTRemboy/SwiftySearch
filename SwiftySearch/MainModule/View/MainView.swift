//
//  MainView.swift
//  SwiftySearch
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var showingResultPage = false
    
    internal var body: some View {
        VStack {
            stats
            Spacer()
            currentNumber
            slider
            button
            Spacer()
            
            .onChange(of: viewModel.result, initial: false) {
                guard viewModel.result != .none else { return }
                showingResultPage = true
            }
        }
        .sheet(isPresented: $showingResultPage, content: {
            ResultView()
                .presentationDetents([.height(320)])
                .presentationBackground(.clear)
                .interactiveDismissDisabled()
        })
    }
    
    private var stats: some View {
        VStack {
            HStack {
                Text("\(Texts.MainPage.level): \(viewModel.currentLevel)")
                    .font(.body())
                Spacer()
                Text("\(Texts.MainPage.score): \(viewModel.score)")
                    .font(.body())
            }
            Text(viewModel.remainingChecksString)
                .padding(.top)
                .font(.segmentTitle())
        }
        .padding([.top, .horizontal])
    }
    
    private var currentNumber: some View {
        Text(viewModel.stringNumber)
            .font(.searchNumber())
    }
    
    private var slider: some View {
        VStack {
            Slider(value: $viewModel.currentNumber, in: viewModel.bounds.min...viewModel.bounds.max, step: 1)
                .padding(.horizontal)
            
            HStack {
                Text(viewModel.stringBounds.min)
                Spacer()
                Text(viewModel.stringBounds.max)
            }
            .padding(.horizontal)
        }
    }
    
    private var button: some View {
        Button {
            viewModel.cutOffGap(current: viewModel.currentNumber)
        } label: {
            Text(Texts.MainPage.check)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(Color.orange)
        .tint(Color.orange)
        .buttonStyle(.bordered)
        
        .padding(.horizontal)
        .padding(.top, 50)
        .padding(.bottom, 100)
    
    }
}

#Preview {
    let environmentObject = MainViewModel()
    return MainView()
        .environmentObject(environmentObject)
}
