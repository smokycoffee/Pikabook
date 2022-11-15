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
    @Published var errorForAlert: ErrorAlerts?
    @Published var pokemonDataToView = [Pokemon]()
    @Published var pokemonURL = [PokedexResults]()
    
    @Published var pokemonListArray = [Pokemon]()

    
    var loading = true
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemons() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokedex.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
            } receiveValue: { [unowned self] pokedex in
                for i in pokedex.results {
                    self.fetchPokemonInfo(for: i.url)
                    loading = false
                }
                //                print(pokemonDataToView)
                self.pokemonURL = pokedex.results
//                print(pokemonURL)
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
                //                print(completion)
            } receiveValue: { [unowned self] pokemon in
                if loading == false {
                    pokemonDataToView.append(pokemon)
                }
            }
            .store(in: &cancellables)
    }
    
    /// Fetch a pokemon from URL
    /// - Parameter urlString: URL of the pokemon
    /// - Returns: A publisher with output PokemonDetailResponse
    func getPokemon (_ urlString: String) -> AnyPublisher<Pokemon, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: Pokemon.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }


    /// Fetch a list of pokemon without details
    /// - Parameter urlString: URL of the list of pokemon
    /// - Returns: A publisher with output PokemonResponse
    func getPokemonList (urlString: String) ->  AnyPublisher<Pokedex, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Pokedex.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }


    /// Fetch a list of pokemon with details
    /// - Returns: A publisher with output an array of PokemonDetailResponse
    func getPokemonListWithDetails () -> AnyPublisher<[Pokemon], Error> {
        return getPokemonList(urlString: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=250")
            .map(\.results)
            .flatMap {
                Publishers
                    .MergeMany($0.map { self.getPokemon($0.url) })
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func testPokemons() {
        
        getPokemonListWithDetails().sink { (completion) in
            print("done")
        } receiveValue: { (pokemons) in
            print(pokemons.map({ "- \($0.name):" }).joined(separator: "\n"))
            self.pokemonListArray = pokemons
        }
        .store(in: &cancellables)
    }


}
