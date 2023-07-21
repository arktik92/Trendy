//
//  UserDetailView.swift
//  TrendyTravel
//
//  Created by Mahdia Amriou on 21/07/2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Image("\(user.profilImage)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(
                        Circle()
                            .stroke(Color.cyan.opacity(0.6), lineWidth: 2)
                            .frame(width: 80, height: 80)
                    )
                Text("\(user.firstName) \(user.lastName)")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    Text("@\(user.pseudo) •")
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 10, weight: .semibold))
                    Text("2541")
                }
                .font(.system(size: 12, weight: .regular))
                
                Text("YouTuber, Vlogger, Travel Creator")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.lightGray))
                
                HStack(spacing: 12) {
                    VStack {
                        Text("3")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Followers")
                            .font(.system(size: 9, weight: .regular))
                    }
                    Spacer()
                        .frame(width: 0.5, height: 12)
                        .background(Color(.lightGray))
                    VStack {
                        Text("2")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Following")
                            .font(.system(size: 9, weight: .regular))
                    }
                }
                
                // Autres éléments de la vue
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("\(user.pseudo)", displayMode: .inline)
    }
}
struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 26, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [])
        UserDetailView(user: user)
    }
}
