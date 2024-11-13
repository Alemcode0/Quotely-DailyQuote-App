//
//  QuoteGalleryView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 12.11.24.
//

import SwiftUI

struct QuoteImageGalleryView: View {
    
    @State var selectedImage: Image?
    
    var image: [String] = ["motivational", "life", "success", "funny", "love", "inspirational", "happiness", "education"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()) ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(image.self, id: \.self) { image in
                    VStack {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                }
            }
        }
        .padding()
        .background(.black)
    }
}

#Preview {
    QuoteImageGalleryView()
}
