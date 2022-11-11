//
//  PokemonTypeCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI
import CachedAsyncImage

struct PokemonDetailsView: View {
    
    @Environment(\.dismiss) var dismiss

    var pokemon: Pokemon
    
    @State var gradientColor: Color = .gray

    var body: some View {
            VStack {
                Group {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 5)
                    Text(pokemon.name.capitalizingFirstLetter())
//                        .padding(.top, 60)
                        .font(.system(.largeTitle, design: .rounded, weight: .medium))
                    Text("#" + String(pokemon.id))
                        .font(.system(.body, design: .rounded, weight: .regular))
                    
                    CachedAsyncImage(url: URL(string: pokemon.sprites?.other?.officialArtwork?.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                                .padding(.top)
                        case .success(let image):
                            image
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding(.top)
                        case .failure:
                            Image(systemName: "questionmark")
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                                .padding(.top)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text("Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.")
                        .font(.system(.footnote))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(gradientColor.opacity(0.8))
                        .cornerRadius(20)
                    
                } // Group
                .foregroundColor(.white)
                
                ControlTabsView(pokemon: pokemon)
            }
            .overlay(content: {
                HStack {
                    Spacer()

                    VStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.down.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                        Spacer()
                    }
                }
            })
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
            .background(RadialGradient(colors: [gradientColor, gradientColor.opacity(0.6), gradientColor], center: .center, startRadius: 100, endRadius: UIScreen.screenWidth - 150))
            .onAppear {
                gradientColor = pokemon.types![0].type.typeColor
            }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []))
    }
}
