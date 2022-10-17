//
//  Pokemon.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import Foundation

struct Pokemon: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites?
    let types: [types]?
}

struct Sprites: Codable, Hashable {
    let frontDefault: String
    let other: OfficialArtWork
}

struct OfficialArtWork: Codable, Hashable {
    let officialArwork: OfficialArtworkImage
    
    enum CodingKeys: String, CodingKey {
        case officialArwork = "official-artwork"
    }
    
    struct OfficialArtworkImage: Codable, Hashable {
        let frontDefault: String
    }
}

struct types: Codable, Hashable {
//    let id: UUID
    let type: OfType
}
struct OfType: Codable, Hashable {
    let name: String
    let url: String
}
