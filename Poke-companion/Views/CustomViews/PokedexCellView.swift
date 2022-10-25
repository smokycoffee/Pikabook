//
//  PokedexCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI
import CachedAsyncImage

struct PokedexCellView: View {
    
    var pokemon: PokemonDetail
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(pokemon.name)
                    .font(.system(.title2, design: .monospaced))
                    .bold()
                    .padding(.bottom)
                HStack {
                    ForEach(pokemon.types!, id: \.self) { i in
                        Text(i.type.name)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .foregroundColor(.white)
                            .font(.system(.body, design: .default, weight: .medium))
                            .background(i.type.typeColor)
                            .cornerRadius(5)
                    }
                }
            }
            Spacer()
            
            CachedAsyncImage(url: URL(string: pokemon.sprites?.other?.officialArtwork.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 90, height: 90)
                case .success(let image):
                    image
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                case .failure:
                    Image(systemName: "questionmark")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .padding()
    }
}


struct PokedexCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexCellView(pokemon: PokemonDetail(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: [])).previewLayout(.sizeThatFits)
    }
}
