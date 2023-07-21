//
//  UserDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    let currentUser: User
    @State var posts: [Post] = []
    @ObservedObject var postViewModel = PostViewModel()
    @State var showModal: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                AsyncImage(url: URL(string: user.profilImage)) { image in
                    image
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
                } placeholder: {
                    Image(user.profilImage)
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
                }
                   
                Text("\(user.firstName) \(user.lastName)")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    Text("@\(user.pseudo) •")
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 10, weight: .semibold))
                    Text("2541")
                }
                .font(.system(size: 12, weight: .regular))
                
                Text(user.description)
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

                    HStack(spacing: 12) {
                        Button(action: {}) {
                            HStack {
                                Spacer()
                                Text("Follow")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .background(Color.cyan)
                            .cornerRadius(50)
                        }
                        Button(action: {}) {
                            HStack {
                                Spacer()
                                Text("Contact")
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .background(Color(white: 0.9))
                            .cornerRadius(50)
                        }
                    }
                    .font(.system(size: 12, weight: .semibold))
                
                
                ForEach(posts.filter {$0.userID == user.id}, id: \.self) { post in
                    PostCellView(post: post, user: user, currentUser: currentUser, posts: $posts)
                }
            }
            .padding(.horizontal)
        }
        .onAppear{
            Task {
                posts = await postViewModel.getPosts()
            }
        }
        .sheet(isPresented: $showModal, content: {
            CreatePostView(posts: $posts, user: currentUser)
        })
        .navigationBarTitle("\(user.pseudo)",  displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 26, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [])
        ProfileView(user: user, currentUser: user)
            .environmentObject(UserViewModel())
    }
}
