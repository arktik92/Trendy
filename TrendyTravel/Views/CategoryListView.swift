//
//  DestinationsCategoriesView.swift
//  TrendyTravel
//
//  Created by Julie Collazos on 26/06/2023.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var categoryViewModel = CategoryViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(categoryViewModel.categories, id: \.self) { category in
                    NavigationLink {
                        DestinationListView(name: category.name)
                    } label: {
                        CategoriesImageAndLabelView(image: category.imageName, title: category.name)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.cyan
                CategoryListView()
            }
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}

