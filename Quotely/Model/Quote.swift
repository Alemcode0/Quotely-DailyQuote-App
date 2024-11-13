//
//  Quote.swift
//  Quotely
//
//  Created by Alemayehu Hailye on 12.11.24.
//

struct Quote : Codable, Identifiable {
    var id: String
    var text: String
    var author: String
    var category: String
    var language: String
}
