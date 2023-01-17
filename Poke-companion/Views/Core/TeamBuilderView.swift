//
//  TeamBuilderView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct TeamBuilderView: View {
    var body: some View {
        NavigationStack {
            VStack {
                PokemonTeamView()
                
                Spacer()
            }
            .navigationTitle("Teams")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TeamBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        TeamBuilderView()
    }
}
