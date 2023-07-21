//
//  PopularDestinationTile.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 20/07/2023.
//

import SwiftUI

struct PopularDestinationTile: View {
    let destination: Destination
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: destination.imageName)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 125, height: 125)
                    .cornerRadius(4)
                    .padding(.all, 6)
            } placeholder: {
                Image(destination.imageName)
            }
                
            Text(destination.city)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .foregroundColor(Color(.label))
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
    }
}

struct PopularDestinationTile_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationTile(destination: Destination(id: 1, country: "", city: "", imageName: "", latitude: 1, longitude: 1, createdAt: "", updatedAt: "", activities: [Activity(id: 1, category: "", name: "", imageName: "", link: "", price: "", latitude: 1, longitude: 1, description: "", rating: 1, destinationID: 1, createdAt: "", updatedAt: "")]))
    }
}
