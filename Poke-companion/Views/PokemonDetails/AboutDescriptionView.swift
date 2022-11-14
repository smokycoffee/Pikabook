//
//  PokemonAboutDescriptionView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI

struct AboutDescriptionView: View {
    
    let pokemon: Pokemon
        
    @StateObject private var pokemonSpeciesVM = PokemonSpeciesViewModel()
    @State var loaded = false
    
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                HStack {
                    
                    VStatLayout(bodyType: String(Double(pokemon.weight) * 0.1), placeholder: "Weight", typeofScale: "Kg")
                    
                    Spacer()
                    
                    Capsule()
                        .frame(width: 2, height: 35)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("types here")
                    
                    Spacer()
                    
                    Capsule()
                        .frame(width: 2, height: 35)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStatLayout(bodyType: Double(pokemon.height * 10).clean, placeholder: "Height", typeofScale: "cm")
                    
                }
                .frame(height: 30)
                .padding(.bottom, 10)
                
                HStack(spacing: 0) {
                    Text("Species:")
                        .font(.system(.body, design: .default, weight: .semibold))
                        .frame(width: 70, alignment: .leading)
                    
                    ForEach(pokemonSpeciesVM.dataToView) { poke in
                        ForEach(poke.eggGroups) { type in
                            Text(type.name)
                            if type != poke.eggGroups.last {
                                Text(",")
                                    .padding(.trailing, 2)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                
                
                HStack(spacing: 0) {
                    Text("Ability:")
                        .font(.system(.body, design: .default, weight: .semibold))
                        .frame(width: 70, alignment: .leading)
                    
                    ForEach(pokemon.abilities) { ability in
                        Text(ability.ability.name + ", ")
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.vertical, 2)
                
                HStatLayout(typeTitle: "Encounters:", assignment: "Kanto", titleWidth: 100)
                    .padding(.vertical, 2)
                
                
                Text("Evolutions:")
                    .font(.system(.body, design: .default, weight: .semibold))
                    .padding(.bottom, 5)
                
                HStack(alignment: .center) {
                    Spacer()
                    ForEach(pokemonSpeciesVM.pokemonEvolutions) { poke in
                        Spacer()
                        AsyncImageView(url: (poke.sprites?.frontDefault)!)
                        Spacer()
                        if poke != pokemonSpeciesVM.pokemonEvolutions.last {
                            Image(systemName: "arrow.forward.circle")
                                .foregroundColor(pokemon.types![0].type.typeColor)
                                .font(.title2)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth)
                
                Spacer()
            }
            .padding()
            .onAppear {
                if loaded == false {
                    pokemonSpeciesVM.fetchPokemonSpecies(for: pokemon.species?.url ?? "ss")
                    loaded = true
                }
            }
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
        .cornerRadius(20, corners: .topLeft)
        .cornerRadius(20, corners: .topRight)
        .ignoresSafeArea()
    }
    // func here
}

struct AboutDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AboutDescriptionView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: [])).previewLayout(.sizeThatFits)
            .frame(height: 400)
    }
}


struct VStatLayout: View {
    
    let bodyType: String
    let placeholder: String
    let typeofScale: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 2) {
                Text(String(bodyType))
                    .font(.system(.body, design: .rounded, weight: .semibold))
                Text(typeofScale)
                    .font(.system(.subheadline, design: .rounded))
            }
            .frame(width: 100)
            Text(placeholder)
                .font(.system(.caption, design: .rounded, weight: .regular))
        }
    }
}

struct HStatLayout: View {
    
    let typeTitle: String
    let assignment: String
    var titleWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            Text(typeTitle)
                .font(.system(.body, design: .default, weight: .semibold))
                .frame(width: titleWidth, alignment: .leading)
            Text(assignment) // change this
                .font(.system(.body, design: .default, weight: .regular))
        }
    }
}
