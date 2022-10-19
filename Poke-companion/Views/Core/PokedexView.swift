//
//  PokedexView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct PokedexView: View {
    
    var pokeDex = [Pokedex]()
    @State var loadPokemons = true
    @StateObject private var pokemonVM = PokedexViewModel()
    
    var body: some View {
        NavigationStack {
            List(pokemonVM.pokemonDataToView) { poke in
                NavigationLink(value: poke) {
                    PokedexCellView(pokemon: poke)
                }
            }
            .navigationTitle("Pokemon")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokedexCellView(pokemon: pokemon)
            }
        }
        .onAppear {
            if loadPokemons == true {
                pokemonVM.fetchPokemons()
                loadPokemons = false
            }
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
