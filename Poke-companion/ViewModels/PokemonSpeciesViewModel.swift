//
//  PokemonSpeciesViewModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 5/11/22.
//

import Foundation
import Combine
import SwiftUI

class PokemonSpeciesViewModel: ObservableObject {
    @Published var dataToView =  [String]()
    @Published var errorForAlert: ErrorAlerts?
    @Published var pokemonDataToView: PokemonSpecies!
    @Published var pokemonEvolutionChainURL: String?
    
    @Published var evolutionChain = PokemonEvolutionChainViewModel()
    
    @Published var pokemonEvolutionChain = [EvolutionChains]()

    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonSpecies(for pokemonSpecies: String) {
        let url = URL(string: pokemonSpecies)!
        
        let decoder = JSONDecoder()
        //        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonSpecies.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] pokemon in
                pokemonDataToView = pokemon
//                print(pokemonDataToView!)
                pokemonEvolutionChainURL = pokemon.evolutionChain.url
//                print(pokemonEvolutionChainURL!)
//                evolutionChain.fetchEvolutionChain(for: pokemonEvolutionChainURL!)
                
                fetchEvolutionChain(for: pokemonEvolutionChainURL!)
                
            }
            .store(in: &cancellables)
    }
    func fetchEvolutionChain(for pokemon: String) {
        
        let url = URL(string: pokemon)!
        
        let decoder = JSONDecoder()
        //        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: EvolutionChains.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] pokemon in
//                self.pokemonDataToView = pokemon
                pokemonEvolutionChain.append(pokemon)
                print(pokemonEvolutionChain)
            }
            .store(in: &cancellables)
        
    }
    
//    func fetchPokemons() {
//        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1154")!
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: Pokedex.self, decoder: decoder)
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                print(completion)
//            } receiveValue: { [unowned self] pokedex in
//
//                let temp = pokedex.results
//                for i in temp {
//                    self.fetchPokemonInfo(for: i.url)
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    func fetchPokemonInfo(for pokemonUrl: String) {
//
//        let url = URL(string: pokemonUrl)!
//
//        let decoder = JSONDecoder()
////        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: Pokemon.self, decoder: decoder)
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                print(completion)
//            } receiveValue: { [unowned self] pokemon in
//                pokemonDataToView.append(pokemon)
//            }
//            .store(in: &cancellables)
//    }
}

