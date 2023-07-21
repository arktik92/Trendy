//
//  CreatePostView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 21/07/2023.
//

import SwiftUI
import PhotosUI


struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var postVm = PostViewModel()
    @ObservedObject var loginVm = LoginViewModel()
    
    @State var newPostTitle: String = ""
    @State var newPostImageName: String = ""
    @State var newPostHashtags: String = ""
    @Binding var posts: [Post]
    @State private var image = UIImage(named: "")
    var user: User
    
    var body: some View {
        VStack {
            PhotoView(image: $image)
                .padding(30)
            TextField("Title", text: $newPostTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.top, 16)
            TextField("Hashtags (comma-separated)", text: $newPostHashtags)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.top, 8)
            
            Button(action: {
                let hashtags = newPostHashtags.components(separatedBy: ",")
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter { !$0.isEmpty }
                
                newPostImageName = postVm.uploadImageToServer()
                postVm.savePosts(title: newPostTitle, imageName: newPostImageName, hashtags: hashtags, userID: user.id)

                Task {
                    
                    posts = await postVm.getPosts()
                }
                
                dismiss()
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
            dismiss()
        })
        
        
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(posts: .constant([Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 0)]), user: User(id: 0, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 0)]))
    }
}
