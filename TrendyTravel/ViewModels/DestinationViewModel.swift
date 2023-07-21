//
//  DestinationDetailsViewModel.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import Foundation

class DestinationViewModel: ObservableObject {
    
    func getDestination() async -> [Destination] {
        var result: [Destination] = []
        guard let url = URL(string: "https://trendytravel.onrender.com/destinations") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Destination].self, from: data) {
                result = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
        return result
    }
}
