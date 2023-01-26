//
//  PokeEncounterVM.swift
//  Poke-companion
//
//  Created by Tsenguun on 26/1/23.
//

import Foundation
import Combine

class PokeEncounterVM: ObservableObject {
    
    @Published var encounter: PokemonEncounter?
    var cancellables: Set<AnyCancellable> = []

    func fetchLocationEncounter(for pokemonUrl: String) {
        let url = URL(string: pokemonUrl)!

        let decoder = JSONDecoder()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonEncounter.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { completion in
            } receiveValue: { [unowned self] pokemon in
                encounter = pokemon
                print(encounter?.locationArea?.name)
//                print(encounter?.name ?? "error")
            }
            .store(in: &cancellables)
    }
}
