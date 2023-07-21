//
//  PopularDestinationsDetailView.swift
//  TrendyTravel
//
//  Created by Esteban SEMELLIER on 20/07/2023.
//

import SwiftUI
import MapKit

struct PopularDestinationsDetailView: View {
    @ObservedObject var vm = DestinationViewModel()
    let destination: Destination
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = true
    
    init(destination: Destination) {
        self.destination = destination
        self.region = MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.07, longitudeDelta: 0.07))
        self.vm = .init()
    }
    
    func activityImages(destination: Destination) -> [String] {
        var images: [String] = []
        for activity in attractions {
            images.append(activity.imageName)
        }
        return images
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            CarouselHeaderView(images: activityImages(destination: destination))
                .frame(height: 250)
            HStack {
                VStack(alignment: .leading) {
                    Text(destination.city)
                        .font(.system(size: 18, weight: .bold))
                    Text(destination.country)
                }
                Spacer()
                HStack {
                    ForEach(0..<5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
            }
            .padding(.horizontal)
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Button(action: {
                    isShowingAttractions.toggle()
                }) {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                        .font(.system(size: 12, weight: .semibold))
                }
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
            }
            .padding()
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }
            .frame(height: 300)
        }
        .navigationBarTitle(destination.city, displayMode: .inline)
    }
    let attractions: [Attraction] = [
        .init(name: "eiffel tower", imageName: "eiffel_tower", latitude: 48.858605, longitude: 2.2946),
        .init(name: "Champs-Elysees", imageName: "new_york", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "art2", latitude: 48.860288, longitude: 2.337789)
    ]
}

struct PopularDestinationsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationsDetailView(destination: Destination(id: 1, country: "", city: "", imageName: "", latitude: 1, longitude: 1, createdAt: "", updatedAt: "", activities: [Activity(id: 1, category: "", name: "", imageName: "", link: "", price: "", latitude: 1, longitude: 1, description: "", rating: 1, destinationID: 1, createdAt: "", updatedAt: "")]))
    }
}
