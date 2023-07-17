//
//  ReviewListView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import SwiftUI

struct ReviewListView: View {
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

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView()
    }
}
