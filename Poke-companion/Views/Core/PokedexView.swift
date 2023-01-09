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
    @State private var searchText = ""
    
    var pokedexData: [Pokemon] {
        if searchText.isEmpty {
            return pokemonVM.pokemonListArray
        } else {
            return pokemonVM.searchResults
        }
    }
    
    var body: some View {
        NavigationStack {
            List(pokedexData, id: \.id) { poke in
                ZStack {
                    PokedexCellView(pokemon: poke)
                        .onTapGesture {
                            self.selectedPokemon = poke
//                            print(selectedPokemon?.moves ?? "no moves")
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
            .searchable(text: $searchText)
            .onChange(of: searchText) { searchText in
                pokemonVM.searchResults = pokemonVM.pokemonListArray.filter({ index in
                    index.name.lowercased().contains(searchText.lowercased())
                })
            }
            .animation(.default, value: searchText)
            
        }
        .onAppear {
            if loaded == false {
                pokemonVM.testPokemons()
                loaded = true
            }
        }

    }
    // func , pokemonListArray = [Pokemon]()
    
}


struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
        }
    }
