//
//  FavouritesView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject var favPokemons = FavouritePokemons()
    @State var selectedPokemon: Pokemon?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favPokemons.listPokemons, id: \.id) { poke in
                    ZStack {
                        PokedexCellView(pokemon: poke)
                            .onTapGesture {
                                self.selectedPokemon = poke
                            }
                        NavigationLink(value: poke) {
                            EmptyView()
                        }
                        .opacity(0)
                    }                }
                .onDelete(perform: RemovePerson)
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .sheet(item: $selectedPokemon, content: { poke in
                PokemonDetailsView(pokemon: poke, favPokemon: FavouritePokemons(), teamBuilder: TeamBuilderViewModel(), pokemonSpeciesVM: PokemonSpeciesViewModel())
                    .presentationDetents([.large])
            })
            .onAppear {
                favPokemons.loadAllFavourites()
            }
            .navigationTitle("Favourites")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UserDefaults.standard.removeObject(forKey: "favPokemon")
                        favPokemons.listPokemons = []
                    } label: {
                        Text("Remove all")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    func RemovePerson(at offsets: IndexSet){
        favPokemons.listPokemons.remove(atOffsets: offsets)
    }
    
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
