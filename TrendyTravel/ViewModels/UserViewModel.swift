//
//  UserViewModel.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    func getUsers() -> [User] {
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
