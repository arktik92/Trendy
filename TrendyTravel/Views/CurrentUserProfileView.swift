//
//  CurrentUserProfileView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 21/07/2023.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    let currentUser: User
    @State var posts: [Post] = []
    @ObservedObject var postViewModel = PostViewModel()
    @State var showModal: Bool = false
    
    var body: some View {
        VStack {
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
            Button {
                showModal.toggle()
            } label: {
                 Text("New Post")
                     .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .background {
                        Color.accentColor
                            .cornerRadius(25)
                    }
            }
        .navigationBarTitle("\(user.pseudo)",  displayMode: .inline)
        }
    }
}
//
//struct CurrentUserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentUserProfileView()
//    }
//}
