//
//  Root.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 18/07/2023.
//

import SwiftUI

struct RootView: View {
    @State var isConnected: Bool = false
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        if !isConnected {
            SignInView(isConnected: $isConnected)
        } else {
            MainView()
        }
            
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
