//
//  PokemonViewModel.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject {

    @Published var pokemonDataToView: [Pokemon]!
    @Published var errorForAlert: ErrorAlerts?
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonInfo(for pokemonUrl: String) {
        
        let url = URL(string: pokemonUrl)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Pokemon].self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [unowned self] pokemon in
                pokemonDataToView = pokemon
                print(pokemonDataToView!)
//                print(pokemonDataToView.name)
//                print(pokemonDataToView.sprites?.frontDefault ?? "no image")
//                print(pokemonDataToView.types ?? "type is not discovered")
            }
            .store(in: &cancellables)
    }
    
}
