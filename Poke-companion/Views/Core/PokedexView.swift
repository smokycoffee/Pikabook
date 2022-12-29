//
//  PokedexView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct PokedexView: View {
    
    @StateObject private var pokemonVM = PokedexViewModel()
    @StateObject private var pokemonSpeciesVM = PokemonSpeciesViewModel()
    
    @State var selectedPokemon: Pokemon?

    @State var loaded = false
    
    @State var testPokemonList = [Pokemon]()


    var body: some View {
        NavigationStack {
            List(pokemonVM.pokemonListArray, id: \.id) { poke in
                ZStack {
                    PokedexCellView(pokemon: poke)
                        .onTapGesture {
                            self.selectedPokemon = poke
                            print(selectedPokemon?.moves ?? "no moves")
                        }
                    NavigationLink(value: poke) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .sheet(item: $selectedPokemon, content: { poke in
                PokemonDetailsView(pokemon: poke)
                    .presentationDetents([.large])
            })
            .navigationTitle("Pokemons")
        }
        .onAppear {
            if loaded == false {
                pokemonVM.testPokemons()
                loaded = true
            }
        }
    }
}


struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
        }
    }
