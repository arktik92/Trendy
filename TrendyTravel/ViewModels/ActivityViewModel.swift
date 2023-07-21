//
//  RestaurantViewModel.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 20/07/2023.
//

import Foundation

class ActivityViewModel: ObservableObject {
    
    func getActivity() async -> [Activity] {
        var result: [Activity] = []
        guard let url = URL(string: "https://trendytravel.onrender.com/activities") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Activity].self, from: data) {
                result = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
        return result
    }
}
