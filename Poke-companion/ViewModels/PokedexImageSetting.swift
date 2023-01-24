//
//  PokedexImageSetting.swift
//  Poke-companion
//
//  Created by Tsenguun on 18/1/23.
//

import Foundation
import Combine

enum PokedexImageType: Int, CaseIterable {
    case Original = 0
    case Official = 1
    case Futuristic = 2
    
    
    init(type: Int) {
        switch type {
        case 0: self = .Original
        case 1: self = .Official
        case 2: self = .Futuristic
        default: self = .Official
        }
}
    var text: String {
        switch self {
        case .Original: return "Original"
        case .Official: return "Official"
        case .Futuristic: return "Futuristic"
        }
    }
}

final class PokedexImageSetting: ObservableObject {
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.imageOrder" : 0,
            "view.preferences.teamImageOrder" : 0,
            "view.preferences.evolutionChainOrderType" : 0,

        ])
        
    }
    @Published var imageOrder: PokedexImageType = PokedexImageType(type: UserDefaults.standard.integer(forKey: "view.preferences.imageOrder")) {
        didSet {
            UserDefaults.standard.set(imageOrder.rawValue, forKey: "view.preferences.imageOrder")
        }
    }
    
    @Published var teamImageOrder: PokedexImageType = PokedexImageType(type: UserDefaults.standard.integer(forKey: "view.preferences.teamImageOrder")) {
        didSet {
            UserDefaults.standard.set(teamImageOrder.rawValue, forKey: "view.preferences.teamImageOrder")
        }
    }
    
    @Published var evolutionChainOrderType: PokedexImageType = PokedexImageType(type: UserDefaults.standard.integer(forKey: "view.preferences.evolutionChainOrderType")) {
        didSet {
            UserDefaults.standard.set(evolutionChainOrderType.rawValue, forKey: "view.preferences.evolutionChainOrderType")
        }
    }
}
