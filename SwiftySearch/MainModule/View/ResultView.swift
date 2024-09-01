//
//  ResultView.swift
//  SwiftySearch
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingBuyAlert = false
    
    internal var body: some View {
        VStack(spacing: 16) {
            if viewModel.result == .success {
                successImage
            } else {
                failureImage
            }
            content
            if viewModel.result == .success {
                levelButton
            } else {
                failureButtons
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 320)
        
        .background(Color.BackColors.backSecondary)
        .clipShape(.rect(cornerRadius: 30))
        
        .padding(.horizontal)
    }
    
    private var successImage: some View {
        Image.ResultsPage.success
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .clipShape(.buttonBorder)
            .padding(.top)
    }
    
    private var failureImage: some View {
        Image.ResultsPage.failure
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .clipShape(.buttonBorder)
            .padding(.top)
    }
    
    private var content: some View {
        VStack(spacing: 10) {
            Text(viewModel.result == .success ? Texts.MainPage.ResultPage.completed : Texts.MainPage.ResultPage.failed)
                .font(.segmentTitle())
            
            HStack(spacing: 40) {
                Text("\(Texts.MainPage.ResultPage.score): \(viewModel.score)")
                Text("\(Texts.MainPage.ResultPage.checks): \(viewModel.checks)")
            }
        }
    }
    
    private var levelButton: some View {
        Button {
            viewModel.nextLevel()
            dismiss()
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
    
    private var failureButtons: some View {
        HStack {
            Button {
                viewModel.restart()
                dismiss()
            } label: {
                Text(Texts.MainPage.ResultPage.restart)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 100, height: 50)
            .minimumScaleFactor(0.4)
            
            .foregroundStyle(Color.orange)
            .tint(Color.orange)
            .buttonStyle(.bordered)
            
            .padding(.horizontal)
            .padding(.vertical)
            
            Button {
                viewModel.buyChecks()
                showingBuyAlert = true
            } label: {
                Text(Texts.MainPage.ResultPage.buy)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .minimumScaleFactor(0.4)
            
            .foregroundStyle(Color.green)
            .tint(Color.green)
            .buttonStyle(.bordered)
            
            .padding(.trailing)
            .padding(.vertical)
            
            .alert(isPresented: $showingBuyAlert) {
                Alert(
                    title: Text(Texts.MainPage.ResultPage.alertTitle),
                    message: Text(Texts.MainPage.ResultPage.alertContent),
                    dismissButton: .default(Text(Texts.MainPage.ResultPage.ok)) {
                        dismiss()
                    }
                )
            }
        }
    }
}

#Preview {
    let environmentObject = MainViewModel()
    return ResultView()
        .environmentObject(environmentObject)
}
