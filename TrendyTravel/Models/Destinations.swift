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
// MARK: - DestinationElement
struct Destination: Codable, Hashable {
    var id: Int
    var country, city: String
    var imageName: String
    var latitude, longitude: Double
    var createdAt, updatedAt: String
    var activities: [Activity]

    enum CodingKeys: String, CodingKey {
        case id, country, city, imageName, latitude, longitude, createdAt, updatedAt
        case activities = "Activities"
    }
}

// MARK: - Activity
struct Activity: Codable, Hashable {
    var id: Int
    var category: String
    var name: String
    var imageName: String
    var link: String
    var price: String
    var latitude, longitude: Double
    var description: String
    var rating, destinationID: Int
    var createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, category, name, imageName, link, price, latitude, longitude, description, rating
        case destinationID = "destinationId"
        case createdAt, updatedAt
    }
}
