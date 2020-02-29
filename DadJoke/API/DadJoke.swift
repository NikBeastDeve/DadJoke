//
//  DadJoke.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 31.01.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct DadJokes: Codable {
    let currentPage, limit, nextPage, previousPage: Int
    let results: [Joke]
    let searchTerm: String
    let status, totalJokes, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case limit
        case nextPage = "next_page"
        case previousPage = "previous_page"
        case results
        case searchTerm = "search_term"
        case status
        case totalJokes = "total_jokes"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
public struct Joke: Codable, Identifiable {
    public let id, joke: String
}

extension Joke: Equatable {
    public static func == (lhs: Joke, rhs: Joke) -> Bool {
        return
            lhs.id == rhs.id
    }
    
    
}
