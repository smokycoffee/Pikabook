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
    let types: [type]?
}

struct Sprites: Codable, Hashable {
    let frontDefault: String
}

struct type: Codable, Hashable {
    let type: OfType
    
    struct OfType: Codable, Hashable {
        let name: String
    }
}
