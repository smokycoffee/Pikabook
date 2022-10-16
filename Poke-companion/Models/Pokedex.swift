//
//  PokedexModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import Foundation

// test with Decodable later

struct Pokedex: Codable, Hashable {
    let count: Int
    let results: [PokedexResults]
}

struct PokedexResults: Codable, Hashable {
    let name: String
    let url: String
}

struct testModel: Codable {
    let url: String
}
