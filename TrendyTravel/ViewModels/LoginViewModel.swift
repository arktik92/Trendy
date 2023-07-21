//
//  LoginViewModel.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var description: String = ""
    @Published var pseudo: String = ""
    @Published var password: String = ""
    @Published var rePassword: String = ""
    @Published var email: String = ""
    @Published var profilImage: String = ""
    @Published var image = UIImage()
    @Published var isConnected = false
//    @Published var currentUser: User = User(id: 1, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 1, title: "", imageName: "", hashtags: [""], userID: 1)])
//    
    var users: [User] = []
    
    init() {
        getCredentialsToUserDefaults()
//        @ObservedObject var userVM = UserViewModel()
    }
    
    func checkSignUpTextFields() -> Bool {
        var isValid = false
        
        if !firstName.isEmpty && !lastName.isEmpty && !description.isEmpty &&  !pseudo.isEmpty && !password.isEmpty && !rePassword.isEmpty && !email.isEmpty {
            if password == rePassword {
                isValid = true
            }
        } else {
            isValid = false
        }
        return isValid
    }
    
    func checkSignInTextFields() -> Bool {
        var isValid = false
        
        if !email.isEmpty && !password.isEmpty {
            isValid = true
        } else {
            isValid = false
        }
        return isValid
    }
    
    func getCurrentUser() -> User {
        var users = getAllUsersFromAPI()
        var emailAndPasswordIsValid = false
        var currentUser: User = User(id: 0, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 0, title: "", imageName: "", hashtags: [""], userID: 0)])
    
        for user in users {
            if self.email == user.email {
                if self.password == user.password {
                    currentUser = user
                    break
                }
            }
        }
        return currentUser
    }
    
    func signIn() -> Bool {
        var users = getAllUsersFromAPI()
        var emailAndPasswordIsValid = false
        var currentUser: User
    
        for user in users {
            if self.email == user.email {
                if self.password == user.password {
                    currentUser = user
                    emailAndPasswordIsValid = true
                    break
                } else {
                    emailAndPasswordIsValid = false
                }
                
            } else {
                emailAndPasswordIsValid = false
            }
        }
        return emailAndPasswordIsValid
    }
    
    func SignUp() {
        guard let url = URL(string: "https://trendytravel.onrender.com/users") else {
            print("Error: cannot create URL")
            return
        }
        
        struct UploadData: Codable {
            var firstName: String
            var lastName: String
            var description: String
            var pseudo: String
            var password: String
            var rePassword: String
            var email: String
            var profilImage: String
        }
        
        let uploadDataModel = UploadData(firstName: firstName, lastName: lastName, description: description, pseudo: pseudo, password: password, rePassword: rePassword, email: email, profilImage: profilImage)
        
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
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                self.saveCredentialsToUserDefaults()
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
        
    }
    
    // MARK: - Image
    func uploadImageToServer() {
        let parameters = ["name": "MyTestFile123321",
                          "id": "12345"]
        guard let mediaImage = Media(withImage: image, forKey: "image") else { return }
        guard let url = URL(string: "https://trendytravel.onrender.com/image") else { return }
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
                
                self.profilImage = imageURL.data
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    self.SignUp()
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
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
    
    func saveCredentialsToUserDefaults() {
        UserDefaults.standard.setValue(self.email, forKey: "email")
        UserDefaults.standard.setValue(self.password, forKey: "password")
    }
    
    func getCredentialsToUserDefaults() {
        email = UserDefaults.standard.string(forKey: "email") ?? ""
        password = UserDefaults.standard.string(forKey: "password") ?? ""
    }
    
    func getAllUsersFromAPI() -> [User]{
        guard let url = URL(string: "https://trendytravel.onrender.com/users") else { return users }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                } catch let jsonError {
                    print("Decoding failed for UserDetails:", jsonError)
                }
            }
        }.resume()
        return users
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
            print("data======>>>",data)
        }
    }
}
