//
//  PostViewModel.swift
//  TrendyTravel
//
//  Created by Mahdia Amriou on 19/07/2023.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func savePosts(title: String, imageName:String, hashtags:[String], userID: Int) {
        guard let url = URL(string: "https://trendytravel.onrender.com/posts") else {
            print("Error: cannot create URL")
            return
        }
        
        struct UploadData: Codable {
            var title, imageName: String
            var hashtags: [String]
            var userId: Int
        }
        
        let uploadDataModel = UploadData(title: title, imageName: imageName, hashtags: hashtags, userId: userID)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard String(data: prettyJsonData, encoding: .utf8) != nil else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    func createPost( userID: Int, title: String, imageName: String, hashtags: [String]) {
        if let userIndex = users.firstIndex(where: { $0.id == userID }) {
            let newPostID = users[userIndex].posts.count + 1
            let newPost = Post(id: newPostID, title: title, imageName: imageName, hashtags: hashtags, userID: userID)

            // Vérifier si le post existe déjà
            let existingPost = users[userIndex].posts.first { $0.title == newPost.title && $0.imageName == newPost.imageName }
            guard existingPost == nil else {
                // Le post existe déjà, ne pas ajouter en double
                return
            }

            users[userIndex].posts.append(newPost)
            savePosts(title: title, imageName: imageName, hashtags: hashtags, userID: userID)


        }
    }
    
    func deletePost(userID: Int, postID: Int) {
        if let userIndex = users.firstIndex(where: { $0.id == userID }) {
            users[userIndex].posts.removeAll { $0.id == postID }
            
            
        }
    }
    
    func editPost(userID: Int, postID: Int, newTitle: String, newImageName: String, newHashtags: [String]) {
            // Trouver l'utilisateur correspondant à l'ID fourni
            guard let userIndex = users.firstIndex(where: { $0.id == userID }) else {
                return // L'utilisateur n'a pas été trouvé, donc rien à faire
            }
            
            // Trouver le post correspondant à l'ID fourni dans les posts de l'utilisateur
            guard let postIndex = users[userIndex].posts.firstIndex(where: { $0.id == postID }) else {
                return // Le post n'a pas été trouvé, donc rien à faire
            }
            
            // Mettre à jour les données du post avec les nouvelles valeurs
            users[userIndex].posts[postIndex].title = newTitle
            users[userIndex].posts[postIndex].imageName = newImageName
            users[userIndex].posts[postIndex].hashtags = newHashtags
            
            // Enregistrer les changements si nécessaire (vous pouvez implémenter cette fonctionnalité)
            // savePosts(title: newTitle, imageName: newImageName, hashtags: newHashtags, userID: userID)
        }
    
}
