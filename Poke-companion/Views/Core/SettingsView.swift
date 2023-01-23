//
//  SettingsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedOrderFavourites = PokedexImageType.Official
    @State private var selectedOrderTeam = PokedexImageType.Official
    @State private var selectedEvolutionImageOrder = PokedexImageType.Official
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    
                    Picker(selection: $selectedOrderFavourites, label: Text("Pokedex Image Type")) {
                        ForEach(PokedexImageType.allCases, id: \.self) {
                            imageType in
                            Text(imageType.text)
                        }
                    }
//                    Picker(selection: $selectedEvolutionImageOrder, labgel: Text("Evolution Image Type")) {
//                        ForEach(PokedexImageType.allCases, id: \.self) {
//                            imageType in
//                            Text(imageType.text)
//                        }
//                    }
                    Picker(selection: $selectedOrderTeam, label: Text("Team Image Type")) {
                        ForEach(PokedexImageType.allCases, id: \.self) {
                            imageType in
                            Text(imageType.text)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.pokedexImageSetting.imageOrder = self.selectedOrderFavourites
                        self.pokedexImageSetting.teamImageOrder = self.selectedOrderTeam
                        self.pokedexImageSetting.evolutionChainOrderType = self.selectedEvolutionImageOrder
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.primary)
                    }
                }
            }
            .onAppear {
                self.selectedOrderFavourites = self.pokedexImageSetting.imageOrder
                self.selectedOrderTeam = self.pokedexImageSetting.teamImageOrder
                self.selectedEvolutionImageOrder = self.pokedexImageSetting.evolutionChainOrderType
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(PokedexImageSetting())
    }
}
