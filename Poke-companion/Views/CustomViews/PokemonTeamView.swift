//
//  PokemonTeamView.swift
//  Poke-companion
//
//  Created by Tsenguun on 1/1/23.
//

import SwiftUI

struct PokemonTeamView: View {
    
    let columns = Array(repeating: GridItem(.flexible() ,spacing: 30), count: 3)
    
    @StateObject var teamPokemons = TeamBuilderViewModel()
    @State private var selectedPokemon: Pokemon?
    @State private var showActionSheet = false
    
    var body: some View {
            VStack {
                Text("Team 1")
                LazyVGrid(columns: columns) {
                    ForEach(teamPokemons.teamPokemons) { poke in
                        PokemonTeamCell(pokemon: poke)
                            .contextMenu {
                                Button(action: {
                                    // delete the selected restaurant
                                    self.delete(item: poke)
                                }) {
                                    HStack {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                            }
                            .onTapGesture {
                                self.showActionSheet.toggle()
                                self.selectedPokemon = poke
                            }
                            .confirmationDialog("Remove Items", isPresented: $showActionSheet) {
                                Button("Delete from team", role: .destructive) {
                                    if let selectedPokemon = self.selectedPokemon {
                                        self.delete(item: selectedPokemon)
                                    }
                                }
                            }
                        //                    .onDrag ({
    //                        gridData.currentGrid = item
    //                        return NSItemProvider(object: String(item.gridText) as NSString)
    //                    })
    //                    .onDrop(of: [.text], delegate: DropViewDelegate(grid: item, gridData: gridData))
                    }
                    .animation(.easeInOut, value: teamPokemons.teamPokemons)
                }
                .padding(10)
            }
            .onAppear {
                teamPokemons.loadAllPokemons()
            }
    }
    private func delete(item pokemon: Pokemon) {
        if let index = self.teamPokemons.teamPokemons.firstIndex(where: { $0.name == pokemon.name })
        {
            self.teamPokemons.teamPokemons.remove(at: index)
        }
    }
}

struct PokemonTeamView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamView().previewLayout(.sizeThatFits)
    }
}
