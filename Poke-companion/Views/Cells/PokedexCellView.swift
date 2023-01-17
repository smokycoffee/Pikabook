//
//  PokedexCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI
import CachedAsyncImage

struct PokedexCellView: View {
    
    var pokemon: Pokemon
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    
    @State var imageUrl: String?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(pokemon.types![0].type.typeColor.opacity(0.3))
                .frame(width: UIScreen.screenWidth - 20, height: 80, alignment: .center)
                .padding(.horizontal)
            HStack {
                VStack(alignment: .leading){
                    Text(pokemon.name.capitalizingFirstLetter())
                        .font(.system(.title3, design: .monospaced))
                        .bold()
                        .padding(.top, 10)
//                        .padding(.bottom)
                    HStack {
                        ForEach(pokemon.types!, id: \.self) { i in
                            Text(i.type.name)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 2)
                                .foregroundColor(.white)
                                .font(.system(.headline, design: .default, weight: .medium))
                                .background(i.type.typeColor)
                                .cornerRadius(5)
                        }
                    }
                }
                .padding(.leading, 20)
                
                Spacer()
                
                CachedAsyncImage(url: URL(string: imageUrl ?? "ss"), urlCache: .imageCache) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 120, height: 120)
                    case .success(let image):
                        image
                            .resizable()
//                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    case .failure:
                        Image(systemName: "questionmark")
                            .resizable()
//                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .onAppear {
                predicate()
            }
//            .frame(height: 100)
            .padding(.horizontal)
        }
    }
    
    func predicate() {
        if pokedexImageSetting.imageOrder == .Original {
            imageUrl = pokemon.sprites?.frontDefault
        } else if pokedexImageSetting.imageOrder == .Official {
            imageUrl = pokemon.sprites?.other?.officialArtwork?.frontDefault
        } else {
            imageUrl = pokemon.sprites?.other?.home?.frontDefault
        }
    }
}


struct PokedexCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexCellView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: [])).previewLayout(.sizeThatFits).environmentObject(PokedexImageSetting())
    }
}
