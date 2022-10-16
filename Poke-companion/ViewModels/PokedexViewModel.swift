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
    @ObservedObject var pokemonUrls = PokemonViewModel()
    
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
//                    dataToView = pokedex.results
                    dataToView.append(i.url)
                    pokemonUrls.fetchPokemonInfo(for: i.url)
                }
//                print(dataToView)

//                print(dataToView!)
            }
            .store(in: &cancellables)
    }
    
}
