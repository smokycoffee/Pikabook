//
//  PokedexView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct PokedexView: View {
    
    @State var loadPokemons = true
    @StateObject private var pokemonVM = PokedexViewModel()
    
    var body: some View {
        NavigationStack {
            List(pokemonVM.pokemonDataToView) { poke in
                ZStack {
                    PokedexCellView(pokemon: poke)
                    NavigationLink(value: poke) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .navigationTitle("Pokemons")
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonTypeCellView(pokemon: pokemon)
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
