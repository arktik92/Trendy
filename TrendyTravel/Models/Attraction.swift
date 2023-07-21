//
//  Attrction.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 20/07/2023.
//

import Foundation


struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name, imageName: String
    let latitude, longitude: Double
}

