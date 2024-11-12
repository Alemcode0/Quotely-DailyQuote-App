//
//  CategoryView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 11.11.24.
//

import SwiftUI

struct CategoryView: View {
    
    var categories: [Category] = [
        Category(name: "Motivational"),
        Category(name: "Life"),
        Category(name: "Success"),
        Category(name: "Funny"),
        Category(name: "Love"),
        Category(name: "Inspirational"),
        Category(name: "Happiness"),
        Category(name: "Friendship")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(categories) { category in
                    VStack {
                        Text(category.name)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(20)
                            .font(.headline)
                    }
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    CategoryView()
}
