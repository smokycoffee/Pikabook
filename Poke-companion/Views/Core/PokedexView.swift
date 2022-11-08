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
    @StateObject private var pokemonSpeciesVM = PokemonSpeciesViewModel()
    
    @State var selectedPokemon: Pokemon?
    
    var body: some View {
        NavigationStack {
            List(pokemonVM.pokemonDataToView, id: \.id) { poke in
                ZStack {
                    PokedexCellView(pokemon: poke)
                        .onTapGesture {
                            self.selectedPokemon = poke
                        }
                    NavigationLink(value: poke) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
//            .sheet(isPresented: $showPokemonDetails, content: {
//                if let selectedPokemon = self.selectedPokemon {
//                    PokemonDetailsView(pokemon: selectedPokemon)
//                }
//            })
            .sheet(item: $selectedPokemon, content: { poke in
                PokemonDetailsView(pokemon: poke)
            })
            .navigationTitle("Pokemons")
//            .navigationDestination(for: Pokemon.self) { pokemon in
//                PokemonDetailsView(pokemon: pokemon)
//            }
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
