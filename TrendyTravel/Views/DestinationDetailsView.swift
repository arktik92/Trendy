//
//  DestinationDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 29/06/2023.
//

import SwiftUI

//struct RestaurantDetails: Codable, Hashable {
//    var id = UUID()
//    let description: String
//    let photos: [String]
//    let reviews: [Review]
//}

//struct ReviewUser: Codable, Hashable {
//    let id: Int
//    let username, firstName, lastName, profileImage: String
//}

struct DestinationDetailsView: View {
    @ObservedObject var vm = DestinationDetailsViewModel()
    let restaurant: Restaurant
    var reviews: [Review]
    var body: some View{
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        HStack {
                            ForEach(0..<5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                            }
                            .foregroundColor(.orange)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Location & Description")
                    .font(.system(size: 16, weight: .bold))
                Text("Tokyo, Japan")
                HStack {
                    ForEach(0..<5, id: \.self) { _ in
                        Image(systemName: "dollarsign.circle.fill")
                    }
                    .foregroundColor(.orange)
                }
                HStack { Spacer() }
            }
            .padding(.top)
            .padding(.horizontal)
            Text(vm.details?.description ?? "")
                .padding(.top, 8)
                .font(.system(size: 14, weight: .regular))
                .padding(.horizontal)
                .padding(.bottom)
            Divider()
                .padding(.horizontal)
            ReviewListView(reviews: reviews)
                .padding(.top)
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}




struct DestinationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DestinationDetailsView(restaurant: .init(name: "Japan's Finest Tapas", image: "tapas"), reviews: [Review(id: 0, content: "Very good restaurant with typical Tokyo habitants and amazing food", rating: 5, userID: 0, activityID: 0)])
        }
    }
}
