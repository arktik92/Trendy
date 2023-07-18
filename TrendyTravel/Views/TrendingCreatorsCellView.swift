//
//  TrendingCreatorsCellView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import SwiftUI

struct TrendingCreatorsCellView: View {
    let user: User
    var body: some View {
        VStack {
            if user.profilImage.hasPrefix("http") {
                AsyncImage(url: URL(string: user.profilImage)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(.infinity)
                } placeholder: {
                    Color.gray
                }
            } else {
                Image(user.profilImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(.infinity)
            }
        

            Text(user.firstName)
                .font(.system(size: 11, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.label))
        }
        .frame(width: 60)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct TrendingCreatorsCellView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCreatorsCellView(user: User(id: 1, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 1, title: "", imageName: "", hashtags: [String("")], userID: 1)]))
    }
}
