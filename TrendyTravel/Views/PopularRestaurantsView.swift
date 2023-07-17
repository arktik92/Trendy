//
//  PopularRestaurantsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct PopularRestaurantsView: View {
    let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Tapas", image: "tapas"),
        .init(name: "Bar & Grill", image: "bar_grill")]
    var body: some View {
        VStack {
            HStack {
                Text("Popular Restaurants")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(restaurants, id: \.self) { restaurant in
                        NavigationLink {
                            RestaurantDetailsView(restaurant: restaurant, reviews: [Review(id: 0, content: "Very good restaurant with typical Tokyo habitants and amazing food", rating: 5, userID: 0, activityID: 0)])
                        } label: {
                            RestaurantTile(restaurant: restaurant)
                                .foregroundColor(Color(.label))
                        }
                        .frame(width: 240)
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RestaurantTile: View {
    let restaurant: Restaurant
    var body: some View {
        HStack(spacing: 8) {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(5)
                .padding(.leading, 6)
                .padding(.vertical, 6)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(restaurant.name)
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
                Text("Tokyo, Japan")
            }
            .font(.system(size: 12, weight: .semibold))
            Spacer()
        }
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView()
    }
}
