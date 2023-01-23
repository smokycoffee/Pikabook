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
    
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    @State var imageUrl: String?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(pokemon.types![0].type.typeColor.opacity(0.5))
                .frame(height: 110)
                .cornerRadius(10)
            
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.system(.callout, design: .monospaced))
                
                CachedAsyncImage(url: URL(string: imageUrl ?? "ss"), urlCache: .imageCache) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 70, height: 70)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    case .failure:
                            Image(systemName: "questionmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .onAppear {
                predicate()
            }
    }
    
    func predicate() {
        if pokedexImageSetting.teamImageOrder == .Original {
            imageUrl = pokemon.sprites?.frontDefault
        } else if pokedexImageSetting.teamImageOrder == .Official {
            imageUrl = pokemon.sprites?.other?.officialArtwork?.frontDefault
        } else if pokedexImageSetting.teamImageOrder == .Futuristic {
            imageUrl = pokemon.sprites?.other?.home?.frontDefault
        }
    }
}

struct PokemonTeamCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamCell(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: [])).environmentObject(PokedexImageSetting())
    }
}
