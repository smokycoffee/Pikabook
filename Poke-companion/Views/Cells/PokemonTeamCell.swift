//
//  PokemonTeamCell.swift
//  Poke-companion
//
//  Created by Tsenguun on 1/1/23.
//

import SwiftUI

struct PokemonTeamCell: View {
    var body: some View {
        Rectangle()
            .fill(Color(.random))
            .frame(height: 100)
    }
}

struct PokemonTeamCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamCell()
    }
}
