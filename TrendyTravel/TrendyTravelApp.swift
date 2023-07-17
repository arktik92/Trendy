//
//  TrendyTravelApp.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

@main
struct TrendyTravelApp: App {
    @StateObject var userVm = UserViewModel()
    @StateObject var catVm = CategoryDetailsViewModel()
    var body: some Scene {
        WindowGroup {
            DestinationsListView()
                .environmentObject(userVm)
                .environmentObject(catVm)
        }
    }
}
