//
//  Platform.swift
//  FinalProject
//
//  Created by Semih Özsoy on 2.06.2021.
//

import UIKit


// MARK: - Results
struct PlatformResults: Decodable {
    let count: Int
    let next, previous: String?
    let results: [PlatformResult]
}

// MARK: - Result
struct PlatformResult: Decodable {
    let id: Int
    let name, slug: String
    let platforms: [PlatformforPlatform]?
}

// MARK: - Platform
struct PlatformforPlatform: Decodable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String?
    let image: String?
    let yearStart: Int?
    let yearEnd: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case image
        case yearStart = "year_start"
        case yearEnd = "year_end"
    }
}



