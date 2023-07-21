//
//  UserDetailsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

//import SwiftUI
//
//
//
//struct ProfileView: View {
//    @EnvironmentObject var postVm: PostViewModel
//
//    @State  var showModal = false
//    @State private var newPostTitle = ""
//    @State private var newPostImageName = ""
//    @State private var newPostHashtags = ""
//
//    let user: User
//    let currentUser: User
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 12) {
//                Image("\(user.profilImage)")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 80)
//                    .clipShape(Circle())
//                    .shadow(radius: 10)
//                    .overlay(
//                        Circle()
//                            .stroke(Color.cyan.opacity(0.6), lineWidth: 2)
//                            .frame(width: 80, height: 80)
//                    )
//                Text("\(user.firstName) \(user.lastName)")
//                    .font(.system(size: 14, weight: .semibold))
//
//                HStack {
//                    Text("@\(user.pseudo) •")
//                    Image(systemName: "hand.thumbsup.fill")
//                        .font(.system(size: 10, weight: .semibold))
//                    Text("2541")
//                }
//                .font(.system(size: 12, weight: .regular))
//
//                Text("YouTuber, Vlogger, Travel Creator")
//                    .font(.system(size: 14, weight: .regular))
//                    .foregroundColor(Color(.lightGray))
//
//                HStack(spacing: 12) {
//                    VStack {
//                        Text("3")
//                            .font(.system(size: 13, weight: .semibold))
//                        Text("Followers")
//                            .font(.system(size: 9, weight: .regular))
//                    }
//                    Spacer()
//                        .frame(width: 0.5, height: 12)
//                        .background(Color(.lightGray))
//                    VStack {
//                        Text("2")
//                            .font(.system(size: 13, weight: .semibold))
//                        Text("Following")
//                            .font(.system(size: 9, weight: .regular))
//                    }
//                }
//                HStack(spacing: 12) {
//                    if user.id != currentUser.id {
//                        Button(action: {}) {
//                            HStack {
//                                Spacer()
//                                Text("Follow")
//                                    .foregroundColor(.white)
//                                Spacer()
//                            }
//                            .padding(.vertical, 8)
//                            .background(Color.blue)
//                            .cornerRadius(50)
//                        }
//                        Button(action: {}) {
//                            HStack {
//                                Spacer()
//                                Text("Contact")
//                                    .foregroundColor(.black)
//                                Spacer()
//                            }
//                            .padding(.vertical, 8)
//                            .background(Color(white: 0.9))
//                            .cornerRadius(50)
//                        }
//                    } else{
//                        Button {
//                            showModal = true
//                        } label: {
//                            HStack {
//                                Spacer()
//                                Text("Create")
//                                    .foregroundColor(.white)
//                                Spacer()
//                            }
//                            .padding(.vertical, 8)
//                            .background(Color.blue)
//                            .cornerRadius(50)
//                            .sheet(isPresented: $showModal) {
//                                NavigationStack {
//                                    VStack {
//                                        TextField("Title", text: $newPostTitle)
//                                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                                            .padding(.horizontal)
//                                            .padding(.top, 16)
//
//                                        TextField("Image Name", text: $newPostImageName)
//                                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                                            .padding(.horizontal)
//                                            .padding(.top, 8)
//
//                                        TextField("Hashtags (comma-separated)", text: $newPostHashtags)
//                                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                                            .padding(.horizontal)
//                                            .padding(.top, 8)
//
//                                        Button(action: {
//                                            let hashtags = newPostHashtags.components(separatedBy: ",")
//                                                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//                                                .filter { !$0.isEmpty }
//
//                                            postVm.createPost(userID: user.id, title: newPostTitle, imageName: newPostImageName, hashtags: hashtags)
//
//                                            showModal = false
//                                            newPostTitle = ""
//                                            newPostImageName = ""
//                                            newPostHashtags = ""
//                                        }) {
//                                            Text("Create Post")
//                                                .font(.system(size: 14, weight: .semibold))
//                                                .foregroundColor(.white)
//                                                .padding()
//                                                .background(Color.blue)
//                                                .cornerRadius(8)
//                                        }
//                                        .padding(.horizontal)
//                                        .padding(.top, 16)
//                                    }
//                                }
//                            }
////                        }
//
//
//
////                        Button(action: {}) {
////                            HStack {
////                                Spacer()
////                                Text("Edit")
////                                    .foregroundColor(.black)
////                                Spacer()
////                            }
////                            .padding(.vertical, 8)
////                            .background(Color(white: 0.9))
////                            .cornerRadius(50)
//                      }
//                    }
//
//                }
//                .font(.system(size: 12, weight: .semibold))
//
//                ForEach(user.posts, id: \.self) { post in
//                    VStack(alignment: .leading) {
//                        Image(post.imageName)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 200)
//                            .clipped()
//                        HStack(alignment: .top) {
//                            Image(user.profilImage)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: 34)
//                                .clipShape(Circle())
//                            VStack(alignment: .leading) {
//                                Text(post.title)
//                                    .font(.system(size: 14, weight: .semibold))
//                                HStack {
//                                    ForEach(post.hashtags, id: \.self) { hashtag in
//                                        Text("#\(hashtag)")
//                                            .foregroundColor(Color.purple)
//                                            .font(.system(size: 13, weight: .semibold))
//                                            .padding(.horizontal, 12)
//                                            .padding(.vertical, 2)
//                                            .background(Color.purple.opacity(0.2))
//                                            .cornerRadius(20)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.horizontal, 8)
//
//                        HStack {
//                            Button {
//                                // action pour ajouter des likes
//                            } label: {
//                                Image(systemName: "hand.thumbsup.fill")
//                                    .foregroundColor(.cyan)
//                                    .font(.system(size: 12))
//                            }
//                            Text("102 likes")
//                                .font(.system(size: 12, weight: .regular))
//                                .foregroundColor(.gray)
//                        }
//                        .padding(.horizontal)
//                        .padding(.bottom, 6)
//
//                        HStack {
//                            if user.id == currentUser.id {
//                                Button(action: {
//                                    //action pour etidter post
//                                    postVm.editPost(userID: user.id, postID: post.id, newTitle: "Nouveau titre", newImageName: "Nouveau nom d'image", newHashtags: ["tag1", "tag2", "tag3"])
//                                 }) {
//                                    Image(systemName: "pencil")
//                                        .foregroundColor(.blue)
//                                }
//
//                                Button(action: {
//                                    // Action pour supprimer le post
//                                    postVm.deletePost(userID: user.id, postID: post.id)
//                                }) {
//                                    Image(systemName: "trash")
//                                        .foregroundColor(.red)
//                                }
//
//                            } else {
//                                //
//                            }
//
//                        }
//                        .padding(.horizontal)
//                        .padding(.bottom, 6)
//                    }
//                    .background(Color(white: 1))
//                    .cornerRadius(12)
//                    .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
//                }
//            }
//            .padding(.horizontal)
//
//        }
//        .navigationBarTitle("\(user.pseudo)", displayMode: .inline)
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User(id: 26, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [])
//        ProfileView(user: user, currentUser: user)
//            .environmentObject(UserViewModel())
//    }
//}
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var postVm: PostViewModel
    
    @State private var showModal = false
    @State private var newPostTitle = ""
    @State private var newPostImageName = ""
    @State private var newPostHashtags = ""
    
    let user: User
    let currentUser: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {

                UserDetailView(user: user)

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
                
                Text("YouTuber, Vlogger, Travel Creator")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.lightGray))

                
                HStack(spacing: 12) {
                    if user.id != currentUser.id {
                        // Affichage des boutons Follow et Contact pour les autres utilisateurs
                        Button(action: {}) {
                            HStack {
                                Spacer()
                                Text("Follow")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .background(Color.blue)
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
                    } else {
                        // Bouton "Create" qui ouvre la modale
                        Button {
                            showModal = true
                        } label: {
                            HStack {
                                Spacer()
                                Text("Create")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(50)
                        }
                        .sheet(isPresented: $showModal) {
                            // Contenu de la modale pour la création de post
                            NavigationView {
                                VStack {
                                    TextField("Title", text: $newPostTitle)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.horizontal)
                                        .padding(.top, 16)
                                    TextField("Image Name", text: $newPostImageName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.horizontal)
                                        .padding(.top, 8)
                                    TextField("Hashtags (comma-separated)", text: $newPostHashtags)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.horizontal)
                                        .padding(.top, 8)
                                    
                                    Button(action: {
                                        let hashtags = newPostHashtags.components(separatedBy: ",")
                                            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                                            .filter { !$0.isEmpty }
                                        
                                        postVm.createPost(userID: user.id, title: newPostTitle, imageName: newPostImageName, hashtags: hashtags)
                                        
                                        showModal = false
                                        newPostTitle = ""
                                        newPostImageName = ""
                                        newPostHashtags = ""
                                    }) {
                                        Text("Create Post")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.blue)
                                            .cornerRadius(8)
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 16)
                                }
                                .navigationBarTitle("Create Post", displayMode: .inline)
                                .navigationBarItems(trailing: Button("Cancel") {
                                    showModal = false
                                })
                            }
                        }
                    }
                }
                .font(.system(size: 12, weight: .semibold))
                
                // Affichage des posts de l'utilisateur
                ForEach(user.posts, id: \.self) { post in
                    VStack(alignment: .leading) {
                        Image(post.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        HStack(alignment: .top) {
                            // Contenu du poste (Titre, hashtags, etc.)
                        }

                        .padding(.horizontal, 8)
                        
                        HStack {
                            Button(action: {
                                showModal = true
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                            Button(action: {
                                postVm.deletePost(userID: currentUser.id, postID: post.id)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 6)
                    .background(Color(white: 1))
                    .cornerRadius(12)
                    .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("\(user.pseudo)", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 26, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [])
        ProfileView(user: user, currentUser: user)
            .environmentObject(UserViewModel())
    }
}
