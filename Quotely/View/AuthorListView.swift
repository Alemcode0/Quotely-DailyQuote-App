//
//  AuthorListView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 14.11.24.
//

import SwiftUI

struct AuthorListView: View {
    
    @State private var authors: [Author] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack {
            
                if isLoading {
                    ProgressView("Loading Authors...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(authors) { author in
                        NavigationLink(destination: AuthorDetailView(author: author)) {
                            VStack(alignment: .leading) {
                                Text(author.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 2)
                                
                                Text("Slug: \(author.slug)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .listRowBackground(Color.blue.opacity(0.6))
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Authors")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5, x: 2, y: 4)
                                
                        }
                    }
                    .listRowSpacing(6)
                    .scrollContentBackground(.hidden)
                    .padding(.bottom, 16)
                }
            }
            .background(
                Image("flower5")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .onAppear {
                fetchAuthors()
            }
            
        }
        
        
        
    }
    
    // Funktion zum Abrufen 
    private func fetchAuthors() {
        isLoading = true
        Task {
            do {
                authors = try await getAuthorsFromAPI()
            } catch let error as HTTPError {
                errorMessage = error.localizedDescription
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    // API-Aufruf für die Autoren
    private func getAuthorsFromAPI() async throws -> [Author] {
        let urlString = "https://api.syntax-institut.de/authors?key=RV7lwPJqlLQyKKsQc1BPPE5RPjhsiruv"
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer RV7lwPJqlLQyKKsQc1BPPE5RPjhsiruv", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HTTPError.invalidResponse
        }
        
        // Dekodiere die JSON-Antwort
        return try JSONDecoder().decode([Author].self, from: data)
    }
}

#Preview {
    AuthorListView()
}
