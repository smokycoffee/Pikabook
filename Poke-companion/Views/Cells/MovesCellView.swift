//
//  MovesCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 30/12/22.
//

import SwiftUI

struct MovesCellView: View {
    let pokemon: Move?
    var body: some View {
        HStack {
            Text(pokemon?.move.name ?? "nil")
            Spacer()
        }
        .padding()
        .background()
        .cornerRadius(10)
    }
}

struct MovesCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovesCellView(pokemon: nil)
    }
}
