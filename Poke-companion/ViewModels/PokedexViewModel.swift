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
    
    /// Fetch a pokemon from URL
    /// - Parameter urlString: URL of the pokemon
    /// - Returns: A publisher with output PokemonDetailResponse
    func getPokemon (_ urlString: String) -> AnyPublisher<Pokemon, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap(\.data)
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
            .tryMap(\.data)
            .decode(type: Pokedex.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }


    /// Fetch a list of pokemon with details
    /// - Returns: A publisher with output an array of PokemonDetailResponse
    func getPokemonListWithDetails () -> AnyPublisher<[Pokemon], Error> {
        return getPokemonList(urlString: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=151")
            .tryMap(\.results)
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
            self.pokemonListArray.append(contentsOf: pokemons)
        }
        .store(in: &cancellables)
    }


}
