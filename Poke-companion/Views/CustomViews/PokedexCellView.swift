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
            VStack {
                Text(pokemon.name)
                    .font(.system(.title2, design: .rounded))
                    .bold()
                //            List {
                //                ForEach(pokemon.types, id: \.self) { pokemon in
                //                    Text(pokemon)
                //                }
                //            }
                Text("Fire example")
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(50)
            }
            Spacer()
            Image(systemName: "person")
                .font(.system(size: 50))
                .controlSize(.large)
                .padding()
        }
        .padding()
    }
}

struct PokedexCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexCellView(pokemon: Pokemon(id: 1, name: "Charizard", sprites: nil, types: nil)).previewLayout(.sizeThatFits)
    }
}
