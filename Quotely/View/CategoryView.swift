//
//  CategoryView.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 11.11.24.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var categories: [String] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    /*var categories: [Category] = [
        Category(name: "Motivational"),
        Category(name: "Life"),
        Category(name: "Success"),
        Category(name: "Funny"),
        Category(name: "Love"),
        Category(name: "Inspirational"),
        Category(name: "Happiness"),
        Category(name: "Education"),
        Category(name: "Future"),
        Category(name: "Wisdom"),
        Category(name: "Courage"),
        Category(name: "Friendship")
    ]*/
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            NavigationStack {
                VStack {
                    if isLoading {
                        ProgressView("Loading categories...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(categories, id: \.self) { category in
                                    NavigationLink(destination: CategoryDetailView(categoryName: category)) {
                                        VStack {
                                            Text(category)
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(.white)
                                                .background(Color.blue.opacity(0.6))
                                                .cornerRadius(20)
                                                .font(.headline)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
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
                        Text("Categories for you")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .onAppear {
                    fetchCategories()
                }
            }
        }
        
        // Funktion, um Kategorien aus der API zu laden
        func getCategoriesFromAPI() async throws -> [String] {
            let urlString = "https://api.syntax-institut.de/categories"
            guard let url = URL(string: urlString) else {
                throw HTTPError.invalidURL
            }
            
            
                let (data, _) = try await URLSession.shared.data(from: url)
                
                /* Überprüfe den HTTP-Statuscode
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print("HTTP Fehlercode: \(httpResponse.statusCode)")
                    throw HTTPError.invalidResponse
                }*/
                
                return try JSONDecoder().decode([String].self, from: data)
                
            
        }
        
        private func fetchCategories() {
            isLoading = true
            errorMessage = nil
            Task {
                do {
                    categories = try await getCategoriesFromAPI()
                } catch let error as HTTPError {
                    errorMessage = handleHTTPError(error)
                } catch {
                    errorMessage = "Unbekannter Fehler: \(error.localizedDescription)"
                }
                isLoading = false
            }
        }
        
        // Fehlerbehandlung
        private func handleHTTPError(_ error: HTTPError) -> String {
            switch error {
            case .invalidURL:
                return "Ungültige URL."
            case .invalidResponse:
                return "Ungültige Antwort vom Server."
            case .decodingError:
                return "Fehler beim Verarbeiten der Daten."
            }
        }
    }
#Preview {
    CategoryView()
}
