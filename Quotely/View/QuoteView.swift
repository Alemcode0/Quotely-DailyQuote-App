//
//  QuoteView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 11.11.24.
//

import SwiftUI

struct QuoteView: View {
    
    @State private var selectedQuote: Quote?
    
    
    
    private var quotes: [Quote] = [
        Quote(id: "1", text: "The only way to do great work is to love what you do.", author: "Steve Jobs", category: "Motivational", language: "English"),
        Quote(id: "2", text: "Life is what happens when you're busy making other plans.", author: "John Lennon", category: "Life", language: "English"),
        Quote(id: "3", text: "Success is not the key to happiness. Happiness is the key to success.", author: "Albert Schweitzer", category: "Success", language: "English"),
        Quote(id: "4", text: "I'm not arguing, I'm just explaining why I'm right.", author: "Unknown", category: "Funny", language: "English"),
        Quote(id: "5", text: "Love is composed of a single soul inhabiting two bodies.", author: "Aristotle", category: "Love", language: "English"),
        Quote(id: "6", text: "The best way to predict the future is to invent it.", author: "Alan Kay", category: "Inspirational", language: "English"),
        Quote(id: "7", text: "Happiness is not something ready made. It comes from your own actions.", author: "Dalai Lama", category: "Happiness", language: "English"),
        Quote(id: "8", text: "Education is the most powerful weapon which you can use to change the world.", author: "Nelson Mandela", category: "Education", language: "English"),
        Quote(id: "9", text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt", category: "Future", language: "English"),
        Quote(id: "10", text: "The only true wisdom is in knowing you know nothing.", author: "Socrates", category: "Wisdom", language: "English"),
        Quote(id: "11", text: "Courage is not the absence of fear, but rather the judgment that something else is more important than fear.", author: "Ambrose Redmoon", category: "Courage", language: "English"),
        Quote(id: "12", text: "A friend is someone who knows all about you and still loves you.", author: "Elbert Hubbard", category: "Friendship", language: "English")
    ]
    
    var body: some View {
        VStack {
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
                            if let quote = selectedQuote {
                                Text(quote.text)
                                    .font(.title2)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .tint(.white)
                                Spacer()
                                Text(" - \(quote.author)")
                            } else {
                                Text("No quote available")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                        }
                            .padding()
                    )
                    .padding()
                
            }
            .onAppear() {
                fetchQuote()
            }
        }
        .background(Image("flower5")
            .resizable()
            .scaledToFill()
            .frame(width: 610))
        
        
    }
    private func fetchQuote() {
        self.selectedQuote = quotes.randomElement()
    }
}




#Preview {
    QuoteView()
}
