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
        Category(name: "Education"),
        Category(name: "Future"),
        Category(name: "Wisdom"),
        Category(name: "Courage"),
        Category(name: "Friendship")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(categories) { category in
                        NavigationLink(destination: CategoryDetailView()) {
                            VStack {
                                Text(category.name)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.4))
                                    .cornerRadius(20)
                                    .font(.headline)
                                    //.foregroundStyle(.white)
                            }
                        }
                        
                    }
                }
                .padding()
            }
            .background(Image("flower5")
                .resizable()
                .scaledToFill()
                .frame(width: 670))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Categories for you")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            
        }
        .font(.largeTitle)
        .foregroundStyle(.white)
        
        
    }
}

#Preview {
    CategoryView()
}
