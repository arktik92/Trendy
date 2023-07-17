//
//  CarouselHeaderView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CarouselHeaderView: View {
    @State private var index = 0
    var images: [String]
    var body: some View {
        VStack {
            TabView(selection: $index) {
                ForEach(images, id: \.self) { index in
                    CarouselCustomBackground(imageName: index, isBlackBackground: false)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 2) {
                ForEach((0..<3), id: \.self) { index in
                    Rectangle()
                        .fill(index == self.index ? Color.cyan : Color.cyan.opacity(0.5))
                        .frame(width: 30, height: 5)
                }
            }
            .padding()
        }
    }
}


struct CarouselCustomBackground: View {
    let imageName: String
    let isBlackBackground: Bool
    var body: some View {
        if isBlackBackground {
            ZStack {
                Color.black
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
        } else {
            Image(imageName)
                .resizable()
                .scaledToFill()
        }
    }
}

struct CarouselHeaderView_Previews: PreviewProvider {
    static let attractionsImages: [String] = [
        .init("eiffel_tower"),
        .init("new_york"),
        .init("art2"),
        .init("art1")
    ]
    
    static var previews: some View {
        CarouselHeaderView(images: attractionsImages)
            .frame(height: 300)
    }
}
