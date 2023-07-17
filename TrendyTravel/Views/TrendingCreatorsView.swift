//
//  TrendingCreatorsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct TrendingCreatorsView: View {
    @EnvironmentObject var vm: UserViewModel
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
            .onAppear {
                vm.users = vm.getUsers()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 40) {
                    ForEach(vm.users, id: \.self) { user in
                        NavigationLink {
                            UserDetailsView(user: user)
                        } label: {
                            DiscoverUserView(user: user)
                        }
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
}

struct DiscoverUserView: View {
    let user: User
    var body: some View {
        VStack {
            Image(user.profilImage)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(.infinity)

            Text(user.firstName)
                .font(.system(size: 11, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.label))
        }
        .frame(width: 60)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCreatorsView()
            .environmentObject(UserViewModel())
    }
}
