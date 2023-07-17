//
//  RestaurantDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 29/06/2023.
//

import SwiftUI


struct RestaurantDetails: Codable, Hashable {
    var id = UUID()
    let description: String
    let photos: [String]
    let reviews: [Review]
}

struct Review: Codable, Hashable {
    var id: Int
    var content: String
    var rating, userID, activityID: Int

    enum CodingKeys: String, CodingKey {
        case id, content, rating
        case userID = "userId"
        case activityID = "activityId"
    }
}

struct ReviewUser: Codable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage: String
}

class RestaurantDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var details: Activity?

    init () {
        let urlString = "https://trendytravel.onrender.com/activities/4"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.details = try? JSONDecoder().decode(Activity.self, from: data)
            }
        }.resume()
    }
}


struct RestaurantDetailsView: View {
    @ObservedObject var vm = RestaurantDetailsViewModel()
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
            ReviewList(reviews: reviews)
                .padding(.top)
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}

struct ReviewList: View {
    var reviews: [Review] = [Review(id: 0, content: "Very good restaurant with typical Tokyo habitants and amazing food", rating: 5, userID: 0, activityID: 0)]
    var body: some View {
        HStack {
            Text("Customer Reviews")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .padding(.horizontal)
            ForEach(reviews, id: \.self) { review in
                VStack(alignment: .leading) {
                    HStack {
                        Image("billy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44)
                                .clipShape(Circle())
                           
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Billy Jones")
                                .font(.system(size: 14,weight: .bold))
                            HStack(spacing: 4) {
                                ForEach(0..<5, id: \.self) { rating in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(rating < review.rating ? .orange : .gray)
                                        .font(.system(size: 12))
                                }
                            }
                        }
                        Spacer()
                        Text("Dec 2020")
                            .font(.system(size: 14, weight: .bold))
                    }
                    Text(review.content)
                        .font(.system(size: 14, weight: .regular))
                }
                .padding(.horizontal)
            }
        }
}


struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailsView(restaurant: .init(name: "Japan's Finest Tapas", image: "tapas"), reviews: [Review(id: 0, content: "Very good restaurant with typical Tokyo habitants and amazing food", rating: 5, userID: 0, activityID: 0)])
        }
    }
}
