//
//  TrendyTravelTests.swift
//  TrendyTravelTests
//
//  Created by Julie Collazos on 26/06/2023.
//

import XCTest
@testable import TrendyTravel

final class TrendyTravelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatePost() {
            // Créez une instance de PostViewModel
            let postViewModel = PostViewModel()

            // Créez des données de test
            let userID = 20
            let title = "Test Post"
            let imageName = "test_image"
            let hashtags = ["travel", "adventure"]

            // Ajoutez un utilisateur fictif avec un post existant
            let user = User(id: userID, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [Post(id: 1, title: "Existing Post", imageName: "existing_image", hashtags: ["existing"], userID: userID)])
            postViewModel.users = [user]

            // Appelez la fonction createPost
            postViewModel.createPost(userID: userID, title: title, imageName: imageName, hashtags: hashtags)

            // Vérifiez si le post a été ajouté avec succès
            let newUser = postViewModel.users.first { $0.id == userID }
            XCTAssertNotNil(newUser, "User not found")
            XCTAssertEqual(newUser?.posts.count, 2, "Post not added successfully")
            XCTAssertEqual(newUser?.posts.last?.title, title, "Incorrect post title")
            XCTAssertEqual(newUser?.posts.last?.imageName, imageName, "Incorrect post image name")
            XCTAssertEqual(newUser?.posts.last?.hashtags, hashtags, "Incorrect post hashtags")

            // Vérifiez si le post n'est pas ajouté en double
            postViewModel.createPost(userID: userID, title: title, imageName: imageName, hashtags: hashtags)
            XCTAssertEqual(newUser?.posts.count, 2, "Post added in duplicate")
        }
    
    func testDeletePost() {
            // Créer des données de test avec un utilisateur et quelques posts
            let user = User(id: 1, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [
                Post(id: 1, title: "Post 1", imageName: "image1", hashtags: ["tag1", "tag2"], userID: 1),
                Post(id: 2, title: "Post 2", imageName: "image2", hashtags: ["tag3", "tag4"], userID: 1),
                Post(id: 3, title: "Post 3", imageName: "image3", hashtags: ["tag5", "tag6"], userID: 1)
            ])
            
            // Créer une instance de PostViewModel avec l'utilisateur de test
            let postViewModel = PostViewModel()
            postViewModel.users = [user]
            
            // Vérifier que l'utilisateur a effectivement 3 posts initialement
            XCTAssertEqual(postViewModel.users[0].posts.count, 3)
            
            // Supprimer le post avec l'ID 2
            postViewModel.deletePost(userID: 1, postID: 2)
            
            // Vérifier que l'utilisateur n'a plus que 2 posts après la suppression
            XCTAssertEqual(postViewModel.users[0].posts.count, 2)
            
            // Vérifier que les posts restants ont les bons titres et IDs
            XCTAssertEqual(postViewModel.users[0].posts[0].id, 1)
            XCTAssertEqual(postViewModel.users[0].posts[0].title, "Post 1")
            XCTAssertEqual(postViewModel.users[0].posts[1].id, 3)
            XCTAssertEqual(postViewModel.users[0].posts[1].title, "Post 3")
        }
    
    func testEditPost() {
            // Créez un exemple de données pour effectuer le test
            let user = User(id: 1, firstName: "John", lastName: "Doe", description: "Description", profilImage: "profile_image", pseudo: "johndoe", password: "password", email: "john@example.com", posts: [
                Post(id: 1, title: "Old Title", imageName: "old_image", hashtags: ["tag1", "tag2"], userID: 1),
                Post(id: 2, title: "Another Title", imageName: "another_image", hashtags: ["tag3"], userID: 1)
            ])
            let viewModel = PostViewModel()
            viewModel.users = [user]
            
            // Appelez la fonction editPost avec de nouvelles valeurs pour le premier post
            viewModel.editPost(userID: 1, postID: 1, newTitle: "New Title", newImageName: "new_image", newHashtags: ["tag3", "tag4"])
            
            // Vérifiez que les valeurs du premier post ont été mises à jour
            XCTAssertEqual(viewModel.users[0].posts[0].title, "New Title")
            XCTAssertEqual(viewModel.users[0].posts[0].imageName, "new_image")
            XCTAssertEqual(viewModel.users[0].posts[0].hashtags, ["tag3", "tag4"])
            
            // Vérifiez que les autres posts n'ont pas été modifiés
            XCTAssertEqual(viewModel.users[0].posts[1].title, "Another Title")
            XCTAssertEqual(viewModel.users[0].posts[1].imageName, "another_image")
            XCTAssertEqual(viewModel.users[0].posts[1].hashtags, ["tag3"])
        }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
