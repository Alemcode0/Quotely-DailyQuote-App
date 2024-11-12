//
//  QuoteView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 11.11.24.
//

import SwiftUI

struct QuoteView: View {
    
    var quotes: [Quote] = []
    
    var body: some View {
        
        VStack {
            Image("Summer1")
                .resizable()
                .scaledToFit()
                .cornerRadius(50)
                .shadow(radius: 3, x: 4, y: 6)
                .overlay(
                    VStack(alignment: .center) {
                        Image("qIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .tint(.yellow)
                        Text("Summertime and the living is easy.")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .bold()
                            .tint(.white)
                        Spacer()
                        Text(" - Alemayehu Hailye")
                    }
                        .padding()
                )
                .padding()
            
            }
        
        
    }
}

#Preview {
    QuoteView()
}
