//
//  QuoteView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 11.11.24.
//

import SwiftUI

struct QuoteView: View {
    
    @State private var selectedQuote: Quote?
    @State private var quotes: [Quote] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                VStack {
                    Image("quoteTitle")
                        .resizable()
                        .scaledToFit()
                        .frame(width:300, height: 200)
                        .padding(.bottom, -40)
                    
                    Image("Summer1")
                        .resizable()
                    //.scaledToFit()
                        .frame(width: 370, height: 530)
                        .cornerRadius(50)
                        .shadow(radius: 3, x: 4, y: 6)
                        .overlay(
                            VStack(alignment: .center) {
                                ZStack {
                                    Image("frame1")
                                        .resizable()
                                        .frame(width: 390, height: 550)
                                        .position(x: 186, y: 264)
                                    
                                    VStack {
                                        if let quote = selectedQuote {
                                            Text(quote.text)
                                                .font(.title)
                                                .multilineTextAlignment(.center)
                                                .foregroundStyle(.syntaxDeepPurple)
                                                .bold()
                                                .padding()
                                            
                                            Spacer(minLength: -30)
                                            
                                            Text(" - \(quote.author)")
                                                .font(.headline)
                                                .foregroundStyle(.syntaxDeepPurple)
                                        } else if isLoading {
                                            ProgressView()
                                        } else if let errorMessage = errorMessage {
                                            Text(errorMessage)
                                                .foregroundColor(.red)
                                        } else {
                                            Text("No quote available")
                                                .font(.title2)
                                                .foregroundStyle(.syntaxDeepPurple)
                                        }
                                    }
                                    .padding()
                                }
                            }
                            
                        )
                        .padding()
                }
                
                Button(action: fetchQuotes) {
                    Label("Next", systemImage: "arrow.forward.circle.dotted")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(.blue)
                .foregroundStyle(.white)
                .padding()
                
            }
            .background(
                Image("flower5")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 670)
            )
            .onAppear {
                fetchQuotes()
            }
            
            Spacer(minLength: 50)
        }
    }
    
    func getQuoteFromAPI() async throws -> [Quote] {
        let urlString = "https://api.syntax-institut.de/quotes"
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        return result
    }
    
    private func fetchQuotes() {
        isLoading = true
        Task {
            do {
                quotes = try await getQuoteFromAPI()
                loadRandomQuote()
            } catch {
                errorMessage = "Failed to load quotes: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    private func loadRandomQuote() {
        if !quotes.isEmpty {
            selectedQuote = quotes.randomElement()
        } else {
            selectedQuote = nil
        }
    }
}

#Preview {
    QuoteView()
}
