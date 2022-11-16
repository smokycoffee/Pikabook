//
//  Api.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/11/22.
//

import Foundation
import Combine

class PokemonSelectedApi  {
    func getPokemon(url: String, completion:@escaping (Pokemon) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemon = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemon)
            }
        }.resume()
    }
}

//func loadPokemons() -> AnyPublisher<PokedexResults, Error> {
//    let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1154")!
//    
//    return URLSession.shared.dataTaskPublisher(for: url)
//        .tryMap { result in
//            guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw URLError(.badServerResponse)
//            }
//            print(result.data.count)
//            return result.data
//        }
//        .decode(type: PokedexResults.self, decoder: JSONDecoder())
//        .receive(on: RunLoop.main)
//        .eraseToAnyPublisher()
//}
//
//func loadPokemonDetails(pokemon: PokedexResults) -> AnyPublisher<Pokemon, Error> {
//    let url = URL(string: pokemon.url)!
//    
//    return URLSession.shared.dataTaskPublisher(for: url)
//        .tryMap { result in
//            guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw URLError(.badServerResponse)
//            }
//            print(result.data)
//
//            return result.data
//        }
//        .decode(type: Pokemon.self, decoder: JSONDecoder())
//        .receive(on: RunLoop.main)
//        .eraseToAnyPublisher()
//}

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
    return getPokemonList(urlString: "https://pokeapi.co/api/v2/pokemon?limit=151")
        .map(\.results)
        .flatMap {
            Publishers
                .MergeMany($0.map { getPokemon($0.url) })
                .collect()
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
}
var cancellables: Set<AnyCancellable> = []

func testPokemons() {
    
    getPokemonListWithDetails().sink { (completion) in
        print("done")
    } receiveValue: { (pokemons) in
        print(pokemons.map({ "- \($0.name):" }).joined(separator: "\n"))
    }
    .store(in: &cancellables)
}

