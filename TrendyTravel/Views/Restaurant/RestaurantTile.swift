//
//  RestaurantTile.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 20/07/2023.
//

import SwiftUI


struct RestaurantTile: View {
    let activity: Activity
    var body: some View {
        HStack(spacing: 8) {
            AsyncImage(url: URL(string: activity.imageName)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(5)
                    .padding(.leading, 6)
                    .padding(.vertical, 6)
            } placeholder: {
                Image(activity.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(5)
                .padding(.leading, 6)
                .padding(.vertical, 6)
            }
               
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(activity.name)
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Image(systemName: "star.fill")
                    Text("4.7")
                }
                .foregroundColor(.black)
                Text("Tokyo, Japan")
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.black)
            Spacer()
        }
    }
}


struct RestaurantTile_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantTile(activity: Activity(id: 0, category: "", name: "", imageName: "", link: "", price: "", latitude: 1, longitude: 1, description: "", rating: 1, destinationID: 1, createdAt: "", updatedAt: ""))
    }
}
