//
//  PokemonTypeCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI
import CachedAsyncImage

struct PokemonTypeCellView: View {
    
    @Environment(\.dismiss) var dismiss

    var pokemon: Pokemon

    var body: some View {
            VStack {
                Group {
                    Text(pokemon.name)
                        .padding(.top, 60)
                        .font(.system(.largeTitle))
                    Text(String(pokemon.id))

//                    Image(systemName: "person")
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                        .padding(.top, 20)
                    
                    CachedAsyncImage(url: URL(string: pokemon.sprites?.other.officialArwork.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                                .padding(.top, 20)
                        case .success(let image):
                            image
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding(.top, 20)
                        case .failure:
                            Image(systemName: "questionmark")
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text("Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.")
                        .padding()
                }
                
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // nav back
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
    }
}

struct PokemonTypeCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeCellView(pokemon: Pokemon(id: 001, name: "Charizard", sprites: nil, types: []))
    }
}
