//
//  EvolutionChains.swift
//  Poke-companion
//
//  Created by Tsenguun on 28/10/22.
//

import Foundation

// MARK: - EvolutionChains
struct EvolutionChains: Codable {
//    let babyTriggerItem: JSONNull?
    let chain: Chain
    let id: Int

}

// MARK: - Chain
struct Chain: Codable {
//    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [Chain]?
    let isBaby: Bool
    let species: SpeciesDuplicate

    enum CodingKeys: String, CodingKey {
//        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

struct EvolvesTo: Codable {
//    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [EvolvesToTwo]?
    let isBaby: Bool
    let species: Species

    enum CodingKeys: String, CodingKey {
//        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

struct EvolvesToTwo: Codable {
//    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [EvolvesToThree]?
    let isBaby: Bool
    let species: Species

    enum CodingKeys: String, CodingKey {
//        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

struct EvolvesToThree: Codable {
//    let evolutionDetails: [EvolutionDetail]?
//    let evolvesTo: []?
    let isBaby: Bool?
    let species: Species?

    enum CodingKeys: String, CodingKey {
//        case evolutionDetails = "evolution_details"
//        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}


// MARK: - EvolutionDetail
//struct EvolutionDetail: Codable {
////    let gender, heldItem, item, knownMove: JSONNull?
////    let knownMoveType, location, minAffection, minBeauty: JSONNull?
////    let minHappiness: JSONNull?
//    let minLevel: Int?
//    let needsOverworldRain: Bool
////    let partySpecies, partyType, relativePhysicalStats: JSONNull?
//    let timeOfDay: String?
////    let tradeSpecies: JSONNull?
//    let trigger: Species
//    let turnUpsideDown: Bool
//
//    enum CodingKeys: String, CodingKey {
////        case gender
////        case heldItem = "held_item"
////        case item
////        case knownMove = "known_move"
////        case knownMoveType = "known_move_type"
////        case location
////        case minAffection = "min_affection"
////        case minBeauty = "min_beauty"
////        case minHappiness = "min_happiness"
//        case minLevel = "min_level"
////        case needsOverworldRain = "needs_overworld_rain"
////        case partySpecies = "party_species"
////        case partyType = "party_type"
////        case relativePhysicalStats = "relative_physical_stats"
//        case timeOfDay = "time_of_day"
////        case tradeSpecies = "trade_species"
////        case trigger
//        case turnUpsideDown = "turn_upside_down"
//    }
//}



// MARK: - Species
struct SpeciesDuplicate: Codable {
    let name: String
    let url: String
}


