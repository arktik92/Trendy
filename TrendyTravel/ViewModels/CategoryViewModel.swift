//
//  DestinationsCategoriesViewModel.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    let categories: [Category] = [
        .init(name: "Culture", imageName: "books.vertical.fill"),
        .init(name: "Spectacles", imageName: "music.mic"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Restaurant", imageName: "fork.knife"),
        .init(name: "Bar", imageName: "wineglass.fill"),
    ]
}
