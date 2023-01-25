//
//  TeamBuilderView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct TeamBuilderView: View {
    @ObservedObject var teamPokemons = TeamBuilderViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                PokemonTeamView()
                
                Spacer()
            }
            .navigationTitle("My Team")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UserDefaults.standard.removeObject(forKey: "teamPokemonOne")
                        teamPokemons.teamPokemons = []
                    } label: {
                        Text("Reset team")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct TeamBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        TeamBuilderView()
    }
}
