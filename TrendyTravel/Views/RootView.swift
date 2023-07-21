//
//  Root.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 18/07/2023.
//

import SwiftUI

struct RootView: View {
    @State var isConnected: Bool = false
    @State var currentUser = User(id: 1, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 1, title: "", imageName: "", hashtags: [""], userID: 1)])
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        if !isConnected {
            SignInView(isConnected: $isConnected, currentUser: $currentUser)
        } else {
            MainView(currentUser: $currentUser)
        }
            
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
