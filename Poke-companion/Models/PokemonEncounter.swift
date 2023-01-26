//
//  PokemonEncounter.swift
//  Poke-companion
//
//  Created by Tsenguun on 26/1/23.
//

import Foundation

struct PokemonEncounter: Codable{
    let locationArea: LocationArea?
    
    enum CodingKeys: String, CodingKey {
        case locationArea = "location_area"
    }
}

struct LocationArea: Codable {
    let name: String?
    let url: String?
}
