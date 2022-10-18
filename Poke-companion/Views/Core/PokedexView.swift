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
        VStack {
            List(pokemonVM.pokemonDataToView) { poke in
                PokedexCellView(pokemon: poke)
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
