//
//  QuoteGalleryView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 12.11.24.
//

import SwiftUI

struct QuoteImageGalleryView: View {
    
    @State private var selectedImage: String? = nil
    @State private var isSheetPresented: Bool = false
    
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
                            .onTapGesture {
                                selectedImage = image
                                isSheetPresented = true
                            }
                    }
                }
            }
        }
        .padding()
        .background(Image("flower5")
            .resizable()
            .scaledToFill()
            .frame(width: 670)
        )
        .sheet(isPresented: $isSheetPresented) {
                    if let selectedImage = selectedImage {
                        EnlargedImageView(imageName: selectedImage)
                    }
                }
        
    }
}

#Preview {
    QuoteImageGalleryView()
}
