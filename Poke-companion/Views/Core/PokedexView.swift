//
//  PokedexView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct PokedexView: View {
    
    var pokeDex = [Pokedex]()

    @StateObject private var pokemonVM = PokedexViewModel()
    @StateObject private var pokemonDetailVM = PokemonViewModel()
    
    var body: some View {
        VStack {
//            List(pokemonDetailVM.pokemonDataToView, id: \.self) { poke in
//                Text(poke.name)
//            }
        }
        .onAppear {
            pokemonVM.fetchPokemons()
            fetchPokemons()
        }
    }
    
    func fetchPokemons() {
//        print(pokemonVM.dataToView)
//        for i in pokemonVM.dataToView {
//            pokemonDetailVM.fetchPokemonInfo(for: i)
//        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
