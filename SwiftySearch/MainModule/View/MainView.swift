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
            currentNumber
            slider
            button
            
            .onChange(of: viewModel.win, initial: false) {
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
        .padding(.vertical, 30)
    
    }
}

#Preview {
    let environmentObject = MainViewModel()
    return MainView()
        .environmentObject(environmentObject)
}
