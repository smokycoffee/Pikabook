//
//  PokemonEvolutionChainViewModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 29/10/22.
//

import Foundation
import Combine
import SwiftUI

class PokemonEvolutionChainViewModel: ObservableObject {
    @Published var dataToView =  [String]()
    @Published var errorForAlert: ErrorAlerts?
    @Published var pokemonDataToView = [EvolutionChains]()
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchEvolutionChain(for pokemon: String) {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/evolution-chain/1/")
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