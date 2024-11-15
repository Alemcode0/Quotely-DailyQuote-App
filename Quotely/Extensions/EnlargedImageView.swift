//
//  EnlargedImageView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 15.11.24.
//

import SwiftUI


struct EnlargedImageView: View {
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding()
                //.background(Color.black.opacity(0.6))
                .cornerRadius(100)
                .shadow(radius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button("Close") {
                
                dismiss()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .background(Color.black.opacity(0.9).edgesIgnoringSafeArea(.all))
    }

    // Dismiss Funktion, die das Sheet schließt
    @Environment(\.dismiss) private var dismiss
}


