//
//  CategoryDetailView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var activities: [Activity] = []
    @Published var errorMessage = ""
    init() {
        let urlString = "https://trendytravel.onrender.com/activities"
        guard let url = URL(string: urlString)
        else {
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad status: \(statusCode)"
                    return
                }
                
                guard let data = data else { return }
                do {
                    self.activities = try JSONDecoder().decode([Activity].self, from: data)
                } catch {
                    print("Failed to decode JSON: ", error)
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }.resume()
    }
}


struct CategoryDetailView: View {
    let name: String
    @EnvironmentObject var vm: CategoryDetailsViewModel
    
    var body: some View {
        if vm.isLoading {
            CategoryDetailLoadingView()
        } else {
            ZStack {
                if !vm.errorMessage.isEmpty {
                    CategoryDetailErrorView(errorMessage: vm.errorMessage)
                }
                ScrollView {
                    ForEach(vm.activities, id: \.self) { activity in
                        CategoryDetailCardView(activity: activity)
                            .navigationBarTitle(activity.category.capitalized, displayMode: .inline)
                    }
                }
            }
            
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailView(name: "culture")
                .environmentObject(CategoryDetailsViewModel())
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}


struct CategoryDetailLoadingView: View {
    var body: some View {
        VStack {
            ActivityIndicatorView()
            Text("Loading...")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
        }
        .padding()
        .background(Color.mint)
        .cornerRadius(8)
    }
}

struct CategoryDetailErrorView: View {
    let errorMessage: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "xmark.octagon.fill")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.red)
            Text(errorMessage)
        }
    }
}

struct CategoryDetailCardView: View {
    let activity: Activity
    
    var destination: Destination {
        for destination in  DestinationViewModel().destinations {
            if   activity.destinationId == destination.id {
                return destination
            }
        }
        return self.destination
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(activity.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(activity.name)
                .font(.system(size: 12, weight: .semibold))
                .padding()
        }
        .padding()
    }
}
