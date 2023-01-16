//
//  PokemonTeamCell.swift
//  Poke-companion
//
//  Created by Tsenguun on 1/1/23.
//

import SwiftUI
import CachedAsyncImage

struct PokemonTeamCell: View {
    var pokemon: Pokemon
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(pokemon.types![0].type.typeColor.opacity(0.5))
                    .frame(height: 100)
                    .cornerRadius(10)
                
                VStack {
                    Text(pokemon.name.capitalized)
                        .font(.system(.callout, design: .monospaced))
                        .padding(.bottom, 10)
                    CachedAsyncImage(url: URL(string: (pokemon.sprites?.frontDefault)!))
                        .frame(width: 40, height: 40)
                    Spacer()
                }

            }
        }
    }
}

struct PokemonTeamCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamCell(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []))
    }
}
