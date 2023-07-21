//
//  PostViewModel.swift
//  TrendyTravel
//
//  Created by Mahdia Amriou on 19/07/2023.
//

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var image = UIImage()
    
    
    func uploadImageToServer() -> String {
        var imageString: String = ""
        let parameters = ["name": "MyTestFile123321",
                          "id": "12345"]
        guard let mediaImage = Media(withImage: image, forKey: "image") else { return "" }
        guard let url = URL(string: "https://trendytravel.onrender.com/image") else { return "" }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //create boundary
        let boundary = generateBoundary()
        //set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //call createDataBody method
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
                let imageURL = try! JSONDecoder().decode(DataImageResponse.self, from: data!)
                print(imageURL)
                
                imageString = imageURL.data
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
        return imageString
    }
    
    func createDataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value as! String + lineBreak)")
            }
        }
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    func getPosts() async -> [Post] {
        var result: [Post] = []
        guard let url = URL(string: "https://trendytravel.onrender.com/posts") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Post].self, from: data) {
                result = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
        return result
    }
    
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
    
    func createHashtags(hashtag: String) -> [String] {
        var hashtags: [String] = []
        
        hashtags.append(hashtag)
        
        return hashtags
    }
    
    func deletePost(postID: Int) {
        
        guard let url = URL(string: "https://trendytravel.onrender.com/posts/\(postID)") else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
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
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    func editPost(userID: Int, postID: Int, newTitle: String, newImageName: String, newHashtags: [String]) {
         
        }
    
}
