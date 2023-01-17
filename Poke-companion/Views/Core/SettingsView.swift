//
//  SettingsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedOrder = PokedexImageType.Official
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    Picker(selection: $selectedOrder, label: Text("Pokedex Image Type")) {
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
                        self.pokedexImageSetting.imageOrder = self.selectedOrder
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.primary)
                    }
                }
            }
            .onAppear {
                self.selectedOrder = self.pokedexImageSetting.imageOrder
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(PokedexImageSetting())
    }
}
