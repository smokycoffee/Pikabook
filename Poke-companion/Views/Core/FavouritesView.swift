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
                PokemonDetailsView(pokemon: poke, favPokemon: FavouritePokemons())
                    .presentationDetents([.large])
            })
            .onAppear {
                favPokemons.loadAllFavourites()
            }
        }
        
        //        .onAppear {
        //            if let savedPokemon = UserDefaults.standard.data(forKey: "favPokemon"){
        //                if let decodedPokemon = try? JSONDecoder().decode([Pokemon].self, from: savedPokemon){
//                    favPokemons.listPokemons = decodedPokemon
//                    return
//                }
//            }
//        }
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
