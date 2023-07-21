//
//  TrendyTravelApp.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI
//
//@main
//struct TrendyTravelApp: App {
//    @StateObject var userVm = UserViewModel()
//    @StateObject var catVm = CategoryDetailsViewModel()
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//                .environmentObject(userVm)
//                .environmentObject(catVm)
//        }
//    }
//}

@main
struct TrendyTravelApp: App {
    @StateObject var userVm = UserViewModel()
       @StateObject var postVm = PostViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
//            MainView()
                .environmentObject(userVm)
                .environmentObject(postVm)
              .onAppear {
                  userVm.getUsers() // Charger les données initiales
               }
        }
    }
}

