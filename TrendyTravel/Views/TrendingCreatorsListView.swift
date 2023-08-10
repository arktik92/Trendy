//
//  TrendingCreatorsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct TrendingCreatorsListView: View {
    @EnvironmentObject var vm: UserViewModel
    var currentUser = User(id: 20, firstName: "djad", lastName: "", description: "xxxxxxx", profilImage: "amy", pseudo: "nnn", password: "", email: "xx@mail", posts: [Post(id: 1, title: "", imageName: "", hashtags: [""], userID: 20)])
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Trending Creators")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.top)
//            .onAppear {
//               vm.getUsers()
//            }
//            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 40) {
                    ForEach(vm.users, id: \.self) { user in
                        NavigationLink(
                            destination: ProfileView(user: user, currentUser: currentUser)
                                .environmentObject(PostViewModel()),
                            label: {
                                TrendingCreatorsCellView(user: user)
                            }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
}



struct TrendingCreatorsListView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCreatorsListView()
            .environmentObject(UserViewModel())
    }
}
