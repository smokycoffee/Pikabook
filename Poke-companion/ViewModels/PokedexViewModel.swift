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
    
    var cancellables: Set<AnyCancellable> = []
    
    let limit = 151
    
    var page = 0
        
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
        
        let offset = page * limit
        return getPokemonList(urlString: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")
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
//        let data = UserDefaults.standard.get(forKey: "pokemonList")
//        if data == nil || data!.count < 200 {
//
//            getPokemonListWithDetails()
//                .sink { (completion) in
//                    print("done")
//                } receiveValue: { (pokemons) in
//                    self.pokemonListArray = pokemons
//                    UserDefaults.standard.set(pokemons, forKey: "pokemonList")
        //                    print("data from pokeapi")
        //                    self.page += 1
        //                }
        //                .store(in: &cancellables)
        //        } else {
        //            self.pokemonListArray = data!
        //            print("data from userDefaults")
        //        }
        getPokemonListWithDetails()
            .sink { (completion) in
                print("done")
            } receiveValue: { (pokemons) in
                self.pokemonListArray = pokemons
                self.page += 1
            }
            .store(in: &cancellables)

//        do {
//            var object: [Pokemon]? = try DataCache.instance.readCodable(forKey: "myKey")
//
//            if object == nil {
//                getPokemonListWithDetails()
//                    .sink { (completion) in
//                        print("done")
//                    } receiveValue: { (pokemons) in
//                        self.pokemonListArray = pokemons
//                        object = self.pokemonListArray
//                        print("data from pokeapi")
//                        self.page += 1
//                        do {
//                            try DataCache.instance.write(codable: object, forKey: "myKey")
//                        } catch {
//                            print("Write error \(error.localizedDescription)")
//                        }
//                    }
//                    .store(in: &cancellables)
//            } else {
//                print("data from datacache")
//                self.pokemonListArray = object!
//            }
//        } catch {
//            print("Read error \(error.localizedDescription)")
//        }
        
        
        
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
                self.page += 1
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

