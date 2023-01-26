//
//  PokemonMovesView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI

struct MovesView: View {

    let pokemon: Pokemon
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(pokemon.moves) { moves in
                                MovesCellView(pokemon: moves)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    .frame(maxHeight: UIScreen.screenHeight / 2)
                    .padding(.top, 10)
                }
            }
            
        }
        .frame(minHeight: 1000)
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
        .cornerRadius(20, corners: .topLeft)
        .cornerRadius(20, corners: .topRight)
        .ignoresSafeArea()
    }
}

struct PokemonMovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []))
    }
}
