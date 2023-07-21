//
//  PopularRestaurantsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct PopularRestaurantsView: View {
   var activities: [Activity]
//    let restaurants: [Restaurant] = [
//        .init(name: "Japan's Finest Tapas", image: "tapas"),
//        .init(name: "Bar & Grill", image: "bar_grill")]
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
                    ForEach(activities.filter {$0.category == "restaurant"}, id: \.self) { activity in
                            NavigationLink {
                                DestinationDetailsView(activity: activity, reviews: [Review(id: 0, content: "Very good restaurant with typical Tokyo habitants and amazing food", rating: 5, userID: 0, activityID: 0)])
                            } label: {
                                RestaurantTile(activity: activity)
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



struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView(activities: [Activity(id: 1, category: "", name: "", imageName: "", link: "", price: "", latitude: 1, longitude: 1, description: "", rating: 1, destinationID: 1, createdAt: "", updatedAt: "")])
    }
}
