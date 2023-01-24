//
//  selectGenerationsEnum.swift
//  Poke-companion
//
//  Created by Tsenguun on 24/1/23.
//

import Foundation

enum GenerationsType: Int, CaseIterable {
    case generationOne = 0
    case generationTwo = 1
    case generationThree = 2
    case generationFour = 3
    case generationFive = 4
    
    init(type: Int) {
        switch type {
        case 0: self = .generationOne
        case 1: self = .generationTwo
        case 2: self = .generationThree
        case 3: self = .generationFour
        case 4: self = .generationFive
        default: self = .generationOne
        }
    }
    
    var text: String {
        switch self {
        case .generationOne: return "Gen 1"
        case .generationTwo: return "Gen 2"
        case .generationThree: return "Gen 3"
        case .generationFour: return "Gen 4"
        case .generationFive: return "Gen 5"

        }
    }
    
//    var generationsCount: (Int) {
//        switch self {
//        case .generationOne:
//            return 151
//        case .generationTwo:
//            return 100
//        case .generationThree:
//            return 135
//        case .generationFour:
//            return 107
//        case .generationFive:
//            return 156
//        }
//    }
//    
//    var generationsOffset: (Int) {
//        switch self {
//        case .generationOne:
//            return 0
//        case .generationTwo:
//            return 151
//        case .generationThree:
//            return 251
//        case .generationFour:
//            return 386
//        case .generationFive:
//            return 493
//        }
//    }
    
}

final class GenerationsTypeSetting: ObservableObject {
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.genOrder" : 0,
        ])
    }
    @Published var genOrder: GenerationsType = GenerationsType(type: UserDefaults.standard.integer(forKey: "view.preferences.genOrder")) {
        didSet {
            UserDefaults.standard.set(genOrder.rawValue, forKey: "view.preferences.genOrder")
        }
    }
}
