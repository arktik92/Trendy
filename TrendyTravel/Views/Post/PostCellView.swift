//
//  PostCellView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 21/07/2023.
//

import SwiftUI

struct PostCellView: View {
    @ObservedObject var viewModel = PostViewModel()
    let post: Post
    let user: User
    let currentUser: User
    @Binding var posts: [Post]
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: post.imageName)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            } placeholder: {
                Image(post.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            }
                 
            HStack(alignment: .top) {
                Image(user.profilImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 34)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.system(size: 14, weight: .semibold))
                    HStack {
                        ForEach(post.hashtags, id: \.self) { hashtag in
                            Text("#\(hashtag)")
                                .foregroundColor(Color.purple)
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 2)
                                .background(Color.purple.opacity(0.2))
                                .cornerRadius(20)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
           
            HStack {
                Button {
                    // action pour ajouter des likes
                } label: {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(.cyan)
                        .font(.system(size: 12))
                }
                Text("102 likes")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
            
            if post.userID == currentUser.id {
                HStack {
                    Button {
                        // edit
                    } label: {
                        Image(systemName: "pencil")
                            .font(.title2)
                            
                    }

                    Button {
                        // Delete
                        viewModel.deletePost(userID: currentUser.id, postID: post.id)
                        Task {
                            posts = await viewModel.getPosts()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .font(.title2)
                    }

                }
                .padding(.horizontal)
                .padding(.bottom, 6)
            }
            
        }
        .background(Color(white: 1))
        .cornerRadius(12)
        .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
    }
}

struct PostCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostCellView(post: Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 1), user: User(id: 0, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 1)]), currentUser: User(id: 0, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 0)]), posts: .constant([Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 0)]))
    }
}
