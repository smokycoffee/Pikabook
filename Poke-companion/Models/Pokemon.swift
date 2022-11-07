//
//  PokemonDetail.swift
//  Poke-companion
//
//  Created by Tsenguun on 25/10/22.
//

import Foundation
import SwiftUI

// MARK: - Pokemon
struct Pokemon: Codable, Hashable, Identifiable {
    
    let id: Int
    let name: String
    let baseExperience: Int?
    let height: Int
    let isDefault: Bool?
    let order, weight: Int
    let abilities: [Ability]
    let forms: [Species]
    let gameIndices: [GameIndex]?
    let heldItems: [HeldItem]?
    let locationAreaEncounters: String?
    let moves: [Move]
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]
    let types: [TypeElement]?
    let pastTypes: [PastType]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order, weight, abilities, forms
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves, species, sprites, stats, types
        case pastTypes = "past_types"
    }
}

// MARK: - Ability
struct Ability: Codable, Hashable, Identifiable {
    let isHidden: Bool?
    let slot: Int
    let ability: Species
    let id = UUID()

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
}

// MARK: - Species
struct Species: Codable, Hashable {
    let name: String
    let url: String
    
    var typeColor: Color {
        switch name {
        case "normal":
            return Color(CGColor(red: 168/255, green: 167/255, blue: 122/255, alpha: 1))
        case "fire":
            return Color(CGColor(red: 238/255, green: 129/255, blue: 48/255, alpha: 1))
        case "water":
            return Color(CGColor(red: 99/255, green: 144/255, blue: 240/255, alpha: 1))
        case "electric":
            return Color(CGColor(red: 247/255, green: 208/255, blue: 44/255, alpha: 1))
        case "grass":
            return Color(CGColor(red: 122/255, green: 199/255, blue: 76/255, alpha: 1))
        case "ice":
            return Color(CGColor(red: 150/255, green: 217/255, blue: 214/255, alpha: 1))
        case "fighting":
            return Color(CGColor(red: 194/255, green: 46/255, blue: 40/255, alpha: 1))
        case "poison":
            return Color(CGColor(red: 163/255, green: 62/255, blue: 161/255, alpha: 1))
        case "ground":
            return Color(CGColor(red: 225/255, green: 191/255, blue: 101/255, alpha: 1))
        case "flying":
            return Color(CGColor(red: 169/255, green: 143/255, blue: 243/255, alpha: 1))
        case "psychic":
            return Color(CGColor(red: 249/255, green: 85/255, blue: 135/255, alpha: 1))
        case "bug":
            return Color(CGColor(red: 166/255, green: 185/255, blue: 26/255, alpha: 1))
        case "rock":
            return Color(CGColor(red: 182/255, green: 161/255, blue: 54/255, alpha: 1))
        case "ghost":
            return Color(CGColor(red: 115/255, green: 87/255, blue: 151/255, alpha: 1))
        case "dragon":
            return Color(CGColor(red: 111/255, green: 53/255, blue: 252/255, alpha: 1))
        case "dark":
            return Color(CGColor(red: 112/255, green: 87/255, blue: 70/255, alpha: 1))
        case "steel":
            return Color(CGColor(red: 183/255, green: 183/255, blue: 206/255, alpha: 1))
        case "fairy":
            return Color(CGColor(red: 214/255, green: 133/255, blue: 173/255, alpha: 1))
        default:
            return .black
            
        }
    }
}

// MARK: - GameIndex
struct GameIndex: Codable, Hashable {
    let gameIndex: Int
    let version: Species

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - HeldItem
struct HeldItem: Codable, Hashable {
    let item: Species
    let versionDetails: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

// MARK: - VersionDetail
struct VersionDetail: Codable, Hashable {
    let rarity: Int
    let version: Species
}

// MARK: - Move
struct Move: Codable, Hashable {
    let move: Species
    let versionGroupDetails: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable, Hashable {
    let levelLearnedAt: Int
    let versionGroup, moveLearnMethod: Species

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }
}

// MARK: - PastType
struct PastType: Codable, Hashable {
    let generation: Species
    let types: [TypeElement]
}

// MARK: - TypeElement
struct TypeElement: Codable, Hashable {
    let slot: Int
    let type: Species
}

// MARK: - GenerationV
struct GenerationV: Codable, Hashable {
    let blackWhite: AnimatedSprites

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - GenerationIv
struct GenerationIv: Codable, Hashable {
    let diamondPearl, heartgoldSoulsilver, platinum: AnimatedSprites

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - Versions
struct Versions: Codable, Hashable {
    let generationI: GenerationI
    let generationIi: GenerationIi
    let generationIii: GenerationIii
    let generationIv: GenerationIv
    let generationV: GenerationV
    let generationVi: [String: Home]
    let generationVii: GenerationVii?
    let generationViii: GenerationViii

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

// MARK: - Sprites
struct Sprites: Codable, Hashable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: AnimatedSprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }

//    init(backDefault: String, backFemale: String, backShiny: String, backShinyFemale: String, frontDefault: String, frontFemale: String, frontShiny: String, frontShinyFemale: String, other: Other?, versions: Versions?, animated: Sprites?) {
//        self.backDefault = backDefault
//        self.backFemale = backFemale
//        self.backShiny = backShiny
//        self.backShinyFemale = backShinyFemale
//        self.frontDefault = frontDefault
//        self.frontFemale = frontFemale
//        self.frontShiny = frontShiny
//        self.frontShinyFemale = frontShinyFemale
//        self.other = other
//        self.versions = versions
//        self.animated = animated
//    }
}

// MARK: - Animated Sprites
struct AnimatedSprites: Codable, Hashable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?
}

// MARK: - GenerationI
struct GenerationI: Codable, Hashable {
    let redBlue, yellow: RedBlue

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - RedBlue
struct RedBlue: Codable, Hashable {
    let backDefault, backGray, frontDefault, frontGray: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
    }
}

// MARK: - GenerationIi
struct GenerationIi: Codable, Hashable {
    let crystal, gold, silver: Crystal
}

// MARK: - Crystal
struct Crystal: Codable, Hashable {
    let backDefault, backShiny, frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - GenerationIii
struct GenerationIii: Codable, Hashable {
    let emerald: Emerald
    let fireredLeafgreen, rubySapphire: Crystal

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - Emerald
struct Emerald: Codable, Hashable {
    let frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Home
struct Home: Codable, Hashable {
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - GenerationVii
struct GenerationVii: Codable, Hashable {
    let icons: DreamWorld?
    let ultraSunUltraMoon: Home

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable, Hashable {
    let frontDefault: String?
    let frontFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - GenerationViii
struct GenerationViii: Codable, Hashable {
    let icons: DreamWorld
}

// MARK: - Other
struct Other: Codable, Hashable {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable, Hashable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stat
struct Stat: Codable, Hashable {
    let baseStat, effort: Int?
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
