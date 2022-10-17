//
//  PokedexCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI

struct PokedexCellView: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(pokemon.name)
                    .font(.system(.title2, design: .rounded))
                    .bold()
                //            List {
                //                ForEach(pokemon.types, id: \.self) { pokemon in
                //                    Text(pokemon)
                //                }
                //            }
                HStack {
                    ForEach(pokemon.types!, id: \.self) { i in
                        Text(i.type.name)
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(50)
                    }
                }
            }
            Spacer()
//            pokemon.sprites?.frontDefault
            AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? "ss")) { phase in
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
                    Image(systemName: "photo")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 100, height: 100)
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
