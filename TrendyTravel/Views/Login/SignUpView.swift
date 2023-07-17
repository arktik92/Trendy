//
//  SignUpView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .mint]), startPoint: .top,
                           endPoint: .center)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                        Spacer()
                }
                
                
                
                VStack {
                    PhotoView()
                        .padding(30)
                    
                    TextField("First name", text: $viewModel.firstName)
                    
                    TextField("Last name", text: $viewModel.lastName)
                    TextField("Username", text: $viewModel.pseudo)
                        .autocorrectionDisabled()
                    TextField("Email", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                    SecureField("Repeat password", text: $viewModel.rePassword)
                    TextField("Description", text: $viewModel.description)
                }
                Spacer()
                
                
                Button {
                    if viewModel.checkSignUpTextFields() == true {
                        // TODO: - Action Creation User
                        Task {
                             viewModel.SignUp()
                        }
                        dismiss()
                    } else {
                        // TODO: - Afficher alert
                    }
                } label: {
                    Text("SignUp")
                        .padding()
                        .foregroundColor(.white)
                        .background {
                            Color.accentColor
                                .cornerRadius(25)
                        }
                    
                }

            }
            .padding()
            .textFieldStyle(.roundedBorder)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
