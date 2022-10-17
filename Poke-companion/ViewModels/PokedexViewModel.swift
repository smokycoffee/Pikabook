//
//  PokedexViewModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import Foundation
import Combine
import SwiftUI

class PokedexViewModel: ObservableObject {
    @Published var dataToView =  [String]()
    @Published var errorForAlert: ErrorAlerts?
    @Published var pokemonDataToView = [Pokemon]()
//    @ObservedObject var pokemonUrls = PokemonViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemons() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1154")!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokedex.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] pokedex in
                
                let temp = pokedex.results
                for i in temp {
                    self.fetchPokemonInfo(for: i.url)
                }
//                print(pokemonDataToView)

            }
            .store(in: &cancellables)
    }
    
//    @Published var errorForAlert: ErrorAlerts?
    
//    var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonInfo(for pokemonUrl: String) {
        
        let url = URL(string: pokemonUrl)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] pokemon in
                pokemonDataToView.append(pokemon)
//                print(pokemon.types)
//                print(pokemonDataToView!)
//                print(pokemonDataToView.name)
//                print(pokemonDataToView.sprites?.frontDefault ?? "no image")
//                print(pokemonDataToView.types ?? "type is not discovered")
            }
            .store(in: &cancellables)
    }
}
