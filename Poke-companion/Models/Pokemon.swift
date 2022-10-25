//
//  Pokemon.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

//import Foundation
//import SwiftUI
//
//struct Pokemon: Codable, Hashable, Identifiable {
//    let id: Int
//    let name: String
//    let sprites: Sprites?
//    let types: [types]?
//}
//
//struct Sprites: Codable, Hashable {
//    let frontDefault: String
//    let other: OfficialArtWork
//}
//
//struct OfficialArtWork: Codable, Hashable {
//    let officialArwork: OfficialArtworkImage
//
//    enum CodingKeys: String, CodingKey {
//        case officialArwork = "official-artwork"
//    }
//
//    struct OfficialArtworkImage: Codable, Hashable {
//        let frontDefault: String
//    }
//}
//
//struct types: Codable, Hashable {
////    let id: UUID
//    let type: OfType
//
//}
//struct OfType: Codable, Hashable {
//    let name: String
//    let url: String
//
//    var typeColor: Color {
//        switch name {
//        case "normal":
//            return Color(CGColor(red: 168/255, green: 167/255, blue: 122/255, alpha: 1))
//        case "fire":
//            return Color(CGColor(red: 238/255, green: 129/255, blue: 48/255, alpha: 1))
//        case "water":
//            return Color(CGColor(red: 99/255, green: 144/255, blue: 240/255, alpha: 1))
//        case "electric":
//            return Color(CGColor(red: 247/255, green: 208/255, blue: 44/255, alpha: 1))
//        case "grass":
//            return Color(CGColor(red: 122/255, green: 199/255, blue: 76/255, alpha: 1))
//        case "ice":
//            return Color(CGColor(red: 150/255, green: 217/255, blue: 214/255, alpha: 1))
//        case "fighting":
//            return Color(CGColor(red: 194/255, green: 46/255, blue: 40/255, alpha: 1))
//        case "poison":
//            return Color(CGColor(red: 163/255, green: 62/255, blue: 161/255, alpha: 1))
//        case "ground":
//            return Color(CGColor(red: 225/255, green: 191/255, blue: 101/255, alpha: 1))
//        case "flying":
//            return Color(CGColor(red: 169/255, green: 143/255, blue: 243/255, alpha: 1))
//        case "psychic":
//            return Color(CGColor(red: 249/255, green: 85/255, blue: 135/255, alpha: 1))
//        case "bug":
//            return Color(CGColor(red: 166/255, green: 185/255, blue: 26/255, alpha: 1))
//        case "rock":
//            return Color(CGColor(red: 182/255, green: 161/255, blue: 54/255, alpha: 1))
//        case "ghost":
//            return Color(CGColor(red: 115/255, green: 87/255, blue: 151/255, alpha: 1))
//        case "dragon":
//            return Color(CGColor(red: 111/255, green: 53/255, blue: 252/255, alpha: 1))
//        case "dark":
//            return Color(CGColor(red: 112/255, green: 87/255, blue: 70/255, alpha: 1))
//        case "steel":
//            return Color(CGColor(red: 183/255, green: 183/255, blue: 206/255, alpha: 1))
//        case "fairy":
//            return Color(CGColor(red: 214/255, green: 133/255, blue: 173/255, alpha: 1))
//        default:
//            return .black
//
//        }
//    }
//
//}
