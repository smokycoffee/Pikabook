//
//  PokemonTeamView.swift
//  Poke-companion
//
//  Created by Tsenguun on 1/1/23.
//

import SwiftUI

struct PokemonTeamView: View {
    
    let columns = Array(repeating: GridItem(.flexible() ,spacing: 30), count: 3)
    

    var body: some View {
        VStack {
            Text("Team 1")
            LazyVGrid(columns: columns) {
                ForEach(0..<6) { item in
                        PokemonTeamCell()
//
//                    .onDrag ({
//                        gridData.currentGrid = item
//                        return NSItemProvider(object: String(item.gridText) as NSString)
//                    })
//                    .onDrop(of: [.text], delegate: DropViewDelegate(grid: item, gridData: gridData))
                }
            }
            .padding(10)
        }
    }
}

struct PokemonTeamView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamView().previewLayout(.sizeThatFits)
    }
}
