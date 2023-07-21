//
//  SearchList.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 20/07/2023.
//

import SwiftUI

struct SearchList: View {
    var searchResults: [Destination]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchResults, id: \.self) { searchResult in
                        NavigationLink {
                            PopularDestinationsDetailView(destination: searchResult)
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 100, height: 180)
                                .foregroundColor(.white)
                                .overlay {
                                    VStack {
                                        AsyncImage(url: URL(string: searchResult.imageName)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                
                                        } placeholder: {
                                            Image(searchResult.imageName)
                                        }
                                        .padding(.horizontal, 5)
                                        Text(searchResult.country)
                                        Text(searchResult.city)
                                    }
                                }
                            
                            
                        }
                    }
                }
            }
        }
    }
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        SearchList(searchResults: [Destination]())
    }
}
