//
//  MainTabView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 13.11.24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            QuoteView()
                .tabItem {
                    Label {
                        Text("Quotes")
                    } icon: {
                        Image(systemName: "quote.bubble.fill")
                        
                    }
                    
                }
            
            CategoryView()
                .tabItem {
                    Label {
                        Text("Category")
                    } icon: {
                        Image(systemName: "square.grid.2x2.fill")
                    }
                    
                }
            
            QuoteImageGalleryView()
                .tabItem {
                    Label {
                        Text("Inspiration")
                    } icon: {
                        Image(systemName: "bubbles.and.sparkles.fill")
                        
                        
                    }
                    
                }
            AuthorListView()
                .tabItem {
                    Label {
                        Text("Author")
                    } icon: {
                        Image(systemName: "bubble.and.pencil")
                        
                        
                    }
                    
                }
            
            
        }
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .systemYellow
            
        })
        
    }
}

#Preview {
    MainTabView()
}
