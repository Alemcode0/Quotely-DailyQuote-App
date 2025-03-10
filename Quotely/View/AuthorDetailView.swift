//
//  AuthorDetailView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 15.11.24.
//

import SwiftUI

struct AuthorDetailView: View {
    var author: Author
    
    @State private var quotes: [Quote] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading Quotes...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(quotes) { quote in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(quote.text)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        Text("- \(quote.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .listRowBackground(Color.blue.opacity(0.6))
                    .padding()
                    .cornerRadius(60)
                }
                .listStyle(PlainListStyle())
                .listRowSpacing(6)
                .scrollContentBackground(.hidden)
                .cornerRadius(40)
                .padding()
                .padding(.bottom, 16)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(author.name)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 4)
                    
            }
        }
        .onAppear {
            fetchQuotesForAuthor()
        }
        .background(
            Image("flower5")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .toolbar(.hidden, for: .tabBar)
    }

    private func fetchQuotesForAuthor() {
        isLoading = true
        Task {
            do {
                quotes = try await getQuotesFromAPI(authorId: author.id)
                isLoading = false
            } catch {
                errorMessage = "Failed to load quotes. Please try again."
                isLoading = false
            }
        }
    }

private func getQuotesFromAPI(authorId: String) async throws -> [Quote] {
    
    let authorSlug = author.slug
    let apiKey = "RV7lwPJqlLQyKKsQc1BPPE5RPjhsiruv"
        
    let urlString = "https://api.syntax-institut.de/quotes?limit=20&author=\(authorSlug)&key=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        throw HTTPError.invalidURL
        
    }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Quote].self, from: data)
    }
    
}





#Preview {
    AuthorDetailView(author: Author.init(id: "1", name: "Alemayehu Hailye", slug: "Keep It Simple"))
}
