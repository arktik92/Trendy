//
//  PhotoView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 17/07/2023.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    // MARK: - Properties
    @State var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @Binding var image: UIImage?
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
           ZStack {
               Circle()
                   .frame(width: 152, height: 152)
               Circle()
                   .foregroundColor(.white)
                   .frame(width: 150, height: 150)
                   .overlay {
                       VStack {
                           Spacer()
                           PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
                               .font(.caption)
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding(.bottom)
                               .padding(.horizontal, 25)
                               .background(Color.gray.opacity(0.8))
                       }
                   }
                   .cornerRadius(75)
               
               if let avatarImage {
                   avatarImage
                       .resizable()
                       .scaledToFill()
                       .frame(width: 150, height: 150)
                       .overlay {
                           VStack {
                               Spacer()
                               PhotosPicker("Change avatar", selection: $avatarItem, matching: .images)
                                   .font(.caption)
                                   .fontWeight(.bold)
                                   .foregroundColor(.white)
                                   .padding(.bottom)
                                   .padding(.horizontal)
                                   .background(Color.gray.opacity(0.8))
                           }
                       }
                       .cornerRadius(75)
               }
           }
           .onChange(of: avatarItem) { _ in
               Task {
                   if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                       if let uiImage = UIImage(data: data) {
                           avatarImage = Image(uiImage: uiImage)
                           image = uiImage
                           return
                       }
                   }

                   print("Failed")
               }
           }
       }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView()
//    }
//}
