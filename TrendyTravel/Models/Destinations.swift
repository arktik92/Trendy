//
//  Destinations.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import Foundation

struct Category: Hashable {
    let name, imageName: String
}

struct Restaurant: Hashable {
    let name, image: String
}

// MARK: - Destination
struct Destination: Codable, Hashable {
    var id: Int
    var country, city, inageName: String
    var latitude, longitude: Double
}

// MARK: - Activity
struct Activity: Codable, Hashable {
    var id: Int
    var category, name, imageName: String
    var link: String
    var price: String
    var latitude, longitude: Double
    var description: String
    var rating, destinationId: Int

    enum CodingKeys: String, CodingKey {
        case id, category, name, imageName, link, price, latitude, longitude, description, rating, destinationId
    }
}
