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
//    @ObservedObject var vm = DestinationDetailsViewModel()
    let activity: Activity
    var reviews: [Review]
    var body: some View{
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: activity.imageName)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(activity.imageName)
                        .resizable()
                        .scaledToFill()
                }
                
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity.name)
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
//            Text(vm.destinations.description)
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
            DestinationDetailsView(activity: Activity(id: 1, category: "", name: "", imageName: "", link: "", price: "", latitude: 1, longitude: 1, description: "", rating: 1, destinationID: 1, createdAt: "", updatedAt: ""), reviews: [Review(id: 1, content: "", rating: 1, userID: 1, activityID: 1)])
        }
    }
}
