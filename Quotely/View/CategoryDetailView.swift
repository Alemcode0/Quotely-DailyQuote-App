//
//  CategoryDetailView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 12.11.24.
//

import SwiftUI

struct CategoryDetailView: View {
    let categoryName: String
        
        @State private var quotes: [Quote] = []
        @State private var isLoading = false
        @State private var errorMessage: String?
        
    var body: some View {
        VStack {
            VStack {
                if isLoading {
                    ProgressView("Loading quotes...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(quotes) { quote in
                        VStack(alignment: .leading) {
                            Text("\"\(quote.text)\"")
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
                    .listRowSpacing(4)
                    .scrollContentBackground(.hidden)
                    //.cornerRadius(40)
                    .padding(.bottom, 16)
                }
            }
            .background(
                Image("flower5")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(categoryName) Quotes")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            //.navigationTitle("\(categoryName) Quotes").foregroundColor(.blue)
            .onAppear {
                fetchQuotes(for: categoryName)
            }
            .toolbar(.hidden, for: .tabBar)
            
        }
        
    }

        // API-Aufruf zum Laden von Zitaten basierend auf der Kategorie
        func getQuotesForCategoryFromAPI(category: String) async throws -> [Quote] {
            let urlString = "https://api.syntax-institut.de/quotes?limit=20&category=\(category)"
            guard let url = URL(string: urlString) else {
                throw HTTPError.invalidURL
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([Quote].self, from: data)
            return result
        }

        // Funktion zum Abrufen der Zitate
        private func fetchQuotes(for category: String) {
            isLoading = true
            errorMessage = nil
            Task {
                do {
                    quotes = try await getQuotesForCategoryFromAPI(category: category)
                } catch {
                    errorMessage = "Failed to load quotes: \(error.localizedDescription)"
                }
                isLoading = false
            }
        }
    }

    #Preview {
        NavigationStack {
            CategoryDetailView(categoryName: "Motivational")
        }
    }
