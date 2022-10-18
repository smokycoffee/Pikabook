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
            
            CachedAsyncImage(url: URL(string: pokemon.sprites?.other.officialArwork.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                switch phase {
                case .empty:
                    ProgressView()
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
        PokedexCellView(pokemon: Pokemon(id: 1, name: "charmander", sprites: nil, types: [])).previewLayout(.sizeThatFits)
    }
}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
