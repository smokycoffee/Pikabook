//
//  Poke_companionApp.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

@main
struct Poke_companionApp: App {
    var pokedexImageSetting = PokedexImageSetting()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(pokedexImageSetting)
        }
    }
}
