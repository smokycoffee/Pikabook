//
//  PokedexViewModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import Foundation
import Combine
import SwiftUI
import DataCache

class PokedexViewModel: ObservableObject {
    @Published var errorForAlert: ErrorAlerts?
    @Published var pokemonDataToView = [Pokemon]()
    @Published var pokemonURL = [PokedexResults]()
    @Published var pokemonListArray = [Pokemon]()
    @Published var searchResults = [Pokemon]()
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var selectedGeneration: GenerationsType = .generationOne
    
    enum State {
            case isLoading
            case done
        }
    
    @Published var generationLimit = 151
    @Published var offsetLimit = 0
    
    @Published var state: State = .isLoading
    
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
    func getPokemonList (urlString: String) -> AnyPublisher<Pokedex, Error> {
        let url = URL(string: urlString)!
        return  URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: Pokedex.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    /// Fetch a list of pokemon with details
    /// - Returns: A publisher with output an array of PokemonDetailResponse
    func getPokemonListWithDetails() -> AnyPublisher<[Pokemon], Error> {
        
//        let offset = page * limit
        return getPokemonList(urlString: "https://pokeapi.co/api/v2/pokemon?limit=\(generationLimit)&offset=\(offsetLimit)")
            .tryMap(\.results)
            .flatMap {
                Publishers
                    .MergeMany($0.map {
                        self.getPokemon($0.url)
                    })
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func testPokemons() {
        state = .isLoading
        
            getPokemonListWithDetails()
                .sink { (completion) in
//                    print("done")
                } receiveValue: {  (pokemons) in
                    
                    self.pokemonListArray.append(contentsOf: pokemons.sorted(by: {
                        $0.id < $1.id
                    }))
                    self.state = .done
                }
                .store(in: &cancellables)
    }
    
    //MARK: Testing api beyond
    
    // test with lead essentials
    
    func loadMore() {
        
        loadPokemons()
            .tryMap(\.results)
            .flatMap {
                Publishers.MergeMany($0.map{
                    self.loadPokemonDetails(pokemon: $0.url)
                })
            }
            .sink { poke in
                //                print("done")
            } receiveValue: { pokmons in
                //                print(pokmons.name)
                self.pokemonListArray.append(pokmons)
            }
            .store(in: &cancellables)
    }
    
    func loadPokemons() -> AnyPublisher<Pokedex, Error> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=999&offset=0")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: Pokedex.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func loadPokemonDetails(pokemon: String) -> AnyPublisher<Pokemon, Error> {
        let url = URL(string: pokemon)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

