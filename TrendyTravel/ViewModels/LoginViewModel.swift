//
//  LoginViewModel.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import Foundation

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
    
    // TODO: Gerer affichage photo
    
    init() {
        getCredentialsToUserDefaults()
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
    
    
    // TODO: - Checker la fonction signIn
    func signIn() {
        guard let url = URL(string: "") else {
            print("Error: cannot create URL")
            return
        }
        
        struct UploadData: Codable {
            var email: String
            var password: String
        }
        
        let uploadDataModel = UploadData(email: email, password: password)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
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
    
    func postImage() {
        guard let url = URL(string: "https://trendytravel.onrender.com/image") else {
            print("Error: cannot create URL")
            return
        }
        
        struct UploadData: Codable {
            var image: String
        }
        
        let uploadDataModel = UploadData(image: profilImage)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
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
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
    func saveCredentialsToUserDefaults() {
        UserDefaults.standard.setValue(self.email, forKey: "email")
        UserDefaults.standard.setValue(self.password, forKey: "password")
    }
    
    func getCredentialsToUserDefaults() {
        email = UserDefaults.standard.string(forKey: "email") ?? ""
        password = UserDefaults.standard.string(forKey: "password") ?? ""
    }
}
