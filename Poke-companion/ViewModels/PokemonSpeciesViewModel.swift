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
    @Published var dataToView = [PokemonSpecies]()
    @Published var errorForAlert: ErrorAlerts?
    @Published var pokemonDataToView = [String]()
    @Published var pokemonEvolutionChainURL: String?
    @Published var pokemonEvolutions = [Pokemon]()
    @Published var pokemonEvolutionChain = [EvolutionChains]()
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonSpecies(for pokemonSpecies: String) {
        let url = URL(string: pokemonSpecies)!
        
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonSpecies.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
//                print(completion)
            } receiveValue: { [unowned self] pokemon in
                pokemonEvolutionChainURL = pokemon.evolutionChain.url
                fetchEvolutionChain(for: pokemonEvolutionChainURL!)
                dataToView.append(pokemon)
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
//                print(completion)
            } receiveValue: { [unowned self] pokemon in
                //                self.pokemonDataToView = pokemon
                pokemonEvolutionChain.append(pokemon)
//                print(pokemonEvolutionChain)
                for chain in pokemonEvolutionChain {
                    pokemonDataToView.append(chain.chain.species.name)
                    for chains in chain.chain.evolvesTo! {
                        pokemonDataToView.append(chains.species.name)
                        for chainss in chains.evolvesTo! {
                            pokemonDataToView.append(chainss.species.name)
                        }
                    }
                }
                for pokemon in pokemonDataToView {
                    fetchPokemonInfo(for: "https://pokeapi.co/api/v2/pokemon/" + pokemon)
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPokemonInfo(for pokemonUrl: String) {
        
        let url = URL(string: pokemonUrl)!
        
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
            } receiveValue: { [unowned self] pokemon in
                pokemonEvolutions.append(pokemon)
//                print(pokemon.sprites?.versions?.generationV.blackWhite.animated.frontDefault)
            }
            .store(in: &cancellables)
    }
}
