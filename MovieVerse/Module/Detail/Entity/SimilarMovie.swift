//
//  Similar.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import Foundation

struct SimilarMovieData: Codable {
    let results: [SimilarMovie]?
    
}
struct SimilarMovie: Codable {
    let id: Int?
    let title: String?
    let posterPath, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
}
