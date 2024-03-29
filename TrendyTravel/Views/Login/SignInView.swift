//
//  SignInView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State var signUpView: Bool = false
    @Binding var isConnected: Bool
    @Binding var currentUser: User
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top,
                           endPoint: .center)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Sign In")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                Spacer()
                
                TextField("Email", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                
                Spacer()
                
                HStack {
                    Text("Don't have an account ?")
                    Button {
                        signUpView.toggle()
                    } label: {
                        Text("it's here")
                    }

                }
                
                Button {
                    if viewModel.checkSignInTextFields() {
                        isConnected = viewModel.signIn()
                        currentUser = viewModel.getCurrentUser()
                    } else {
                        // TODO: - Afficher alert
                    }
                } label: {
                    Text("Sign In")
                        .padding()
                        .foregroundColor(.white)
                        .background {
                            Color.accentColor
                                .cornerRadius(25)
                        }
                }
            }
            .onAppear {
                isConnected = viewModel.signIn()
            }
            .padding()
            .textFieldStyle(.roundedBorder)
        }
        .sheet(isPresented: $signUpView) {
            SignUpView()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isConnected: .constant(false),currentUser: .constant(User(id: 1, firstName: "", lastName: "", description: "", profilImage: "", pseudo: "", password: "", email: "", posts: [Post(id: 1, title: "", imageName: "", hashtags: [""], userID: 1)])))
    }
}
