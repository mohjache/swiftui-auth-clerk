//
//  ContentView.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 7/3/2025.
//

import SwiftUI
import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations

@ViewWithViewModel
struct RootView {
    var content: some View {
        VStack {
            
            if vm.authenticatied {
                Text("Hello Logged In")
            } else {
                Text("Please Login")
            }
        }
        .padding()
    }
}

@ViewModel(generateEmpty: true)
final class RootViewViewModel {
    var authenticatied: Bool = false
}

#Preview {
    RootView()
}
