//
//  PopularDestinationsView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct PopularDestinationsView: View {
   @ObservedObject var viewModel = DestinationViewModel()
    @Binding var destinations : [Destination]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular Destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink {
                            PopularDestinationsDetailView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                                .padding(.bottom)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        
    }
}
//
//struct PopularDestinationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopularDestinationsView(, destinations: <#Binding<[Destination]>#>)
//        
//    }
//}

