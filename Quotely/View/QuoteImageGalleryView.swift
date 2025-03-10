//
//  QuoteGalleryView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 12.11.24.
//

import SwiftUI

struct QuoteImageGalleryView: View {
    
    @State private var selectedImage: ImageGallery? = nil
    @State private var isSheetPresented: Bool = false
    
    @State var images: [ImageGallery] = [
        ImageGallery(title: "Motivational", images: "motivational"),
        ImageGallery(title: "Life", images: "life"),
        ImageGallery(title: "Success", images: "success"),
        ImageGallery(title: "Funny", images: "funny"),
        ImageGallery(title: "Love", images: "love"),
        ImageGallery(title: "Inspirational", images: "inspirational"),
        ImageGallery(title: "Happiness", images: "happiness"),
        ImageGallery(title: "Education", images: "education")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(images) { imageGallery in
                    VStack {
                        Image(imageGallery.images)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .onTapGesture {
                                selectedImage = imageGallery
                                isSheetPresented = true
                            }
                        
                        Text(imageGallery.title)
                            .font(.headline)
                            .padding(.top, 5)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .background(
            Image("flower5")
                .resizable()
                .scaledToFill()
                .frame(width: 670)
        )
        .sheet(isPresented: $isSheetPresented) {
            if let selectedImage = selectedImage {
                VStack {
                    Text(selectedImage.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
                    Image(selectedImage.images)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Button("Close") {
                        isSheetPresented = false
                    }
                    .padding()
                    .background(Color.blue)
                    .clipShape(.capsule)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

#Preview {
    QuoteImageGalleryView()
}
