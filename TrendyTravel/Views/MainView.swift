//
//  DestinationsListView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var searchText: String = ""
    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var destinationViewModel = DestinationViewModel()
    @ObservedObject var activityViewModel = ActivityViewModel()
    @State var destinations: [Destination] = []
    @State var activities: [Activity] = []
    @Binding var currentUser: User
   
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top,
                               endPoint: .center)
                .ignoresSafeArea()
            
                if searchText != "" {
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Where do you want to go?", text: $searchText)
                            Spacer()
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(10)
                        .padding(16)
                        CategoryListView()
                            .padding()
                        SearchList(searchResults: searchResults)
                    }
                } else {
                    Color.white
                        .offset(y: 400)
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Where do you want to go?", text: $searchText)
                            Spacer()
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.3)))
                        .cornerRadius(10)
                        .padding(16)
                        CategoryListView()
                        VStack {
                            PopularDestinationsView(destinations: $destinations)
                            PopularRestaurantsView(activities: activities)
                            TrendingCreatorsListView()
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.top, 32)
                    }
                    .navigationTitle("Discover")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ProfileView(user: currentUser)
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.white)
                    }


                }
            }
        }
        .onAppear {
            Task {
                destinations = await destinationViewModel.getDestination()
                activities = await activityViewModel.getActivity()
            }
        }
    }
    var searchResults: [Destination] {
           if searchText.isEmpty {
               return destinations
           } else {
               return destinations.filter { $0.country.contains(searchText) || $0.city.contains(searchText) }
           }
       }
}

struct MainView_Previews: PreviewProvider {
//    @EnvironmentObject var userVm = UserViewModel()
    static var previews: some View {
        MainView(currentUser: .constant(User(id: 1, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 1, title: "", imageName: "", hashtags: [""], userID: 1)])))
            .colorScheme(.light)
            .environmentObject(UserViewModel())
            .environmentObject(DestinationViewModel())
            .environmentObject(CategoryDetailsViewModel())
        MainView(currentUser: .constant(User(id: 1, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 1, title: "", imageName: "", hashtags: [""], userID: 1)])))
            .colorScheme(.dark)
            .environmentObject(UserViewModel())
            .environmentObject(DestinationViewModel())
            .environmentObject(CategoryDetailsViewModel())
    }
}
