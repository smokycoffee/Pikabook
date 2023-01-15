//
//  FavouritePokemons.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/1/23.
//

import Foundation

 
class FavouritePokemons: ObservableObject {
    @Published var listPokemons = [Pokemon](){
        didSet{
            // every time value of lstPeople change, system will save new value
            // into UserDefaults
            let encoder = JSONEncoder()
             
            if let encoded = try? encoder.encode(listPokemons){
                UserDefaults.standard.set(encoded, forKey: "favPokemon")
            }
        }
    }
    
    func loadAllFavourites() {
        if let savedPokemon = UserDefaults.standard.data(forKey: "favPokemon"){
            if let decodedPokemon = try? JSONDecoder().decode([Pokemon].self, from: savedPokemon){
                listPokemons = decodedPokemon
                return
            }
        }
        listPokemons = []
    }

    init() {
        // everytime we create an instance of People, system will load the value
        // from UserDefaults
        if let savedPokemon = UserDefaults.standard.data(forKey: "favPokemon"){
            if let decodedPokemon = try? JSONDecoder().decode([Pokemon].self, from: savedPokemon){
                listPokemons = decodedPokemon
                return
            }
        }
        listPokemons = []
    }
}

