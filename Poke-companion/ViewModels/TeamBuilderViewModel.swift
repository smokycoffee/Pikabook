//
//  TeamBuilderViewModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 16/1/23.
//

import Foundation
 
class TeamBuilderViewModel: ObservableObject {
    
    @Published var currentPokemon: Pokemon?
    
    @Published var teamPokemons = [Pokemon](){
        didSet{
            // every time value of lstPeople change, system will save new value
            // into UserDefaults
            let encoder = JSONEncoder()
             
            if let encoded = try? encoder.encode(teamPokemons){
                UserDefaults.standard.set(encoded, forKey: "teamPokemonOne")
            }
        }
    }
    
    func loadAllPokemons() {
        if let savedPokemon = UserDefaults.standard.data(forKey: "teamPokemonOne"){
            if let decodedPokemon = try? JSONDecoder().decode([Pokemon].self, from: savedPokemon){
                teamPokemons = decodedPokemon
                return
            }
        }
        teamPokemons = []
    }

    init() {
        // everytime we create an instance of People, system will load the value
        // from UserDefaults
        if let savedPokemon = UserDefaults.standard.data(forKey: "teamPokemonOne"){
            if let decodedPokemon = try? JSONDecoder().decode([Pokemon].self, from: savedPokemon){
                teamPokemons = decodedPokemon
                return
            }
        }
        teamPokemons = []
    }
}
