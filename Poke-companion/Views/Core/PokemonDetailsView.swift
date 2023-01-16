//
//  PokemonTypeCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI
import CachedAsyncImage

struct PokemonDetailsView: View {
    
    @Environment(\.dismiss) var dismiss

    var pokemon: Pokemon
        
    @State var gradientColor: Color = .gray
    @ObservedObject var favPokemon: FavouritePokemons
    @ObservedObject var teamBuilder: TeamBuilderViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Group {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 5)
                        Text(pokemon.name.capitalizingFirstLetter())
                            .font(.system(.largeTitle, design: .rounded, weight: .medium))
                        Text("#" + String(pokemon.id))
                            .font(.system(.body, design: .rounded, weight: .regular))
                        
                        CachedAsyncImage(url: URL(string: pokemon.sprites?.other?.officialArtwork?.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                //                                .interpolation(.none)
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                            case .failure:
                                Image(systemName: "questionmark")
                                    .resizable()
                                //                                .interpolation(.none)
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Text("Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.")
                            .font(.system(.footnote))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(gradientColor.opacity(0.8))
                            .cornerRadius(20)
                        
                    } // Group
                    .foregroundColor(.white)
                    
                    ControlTabsView(pokemon: pokemon)
                        .frame(height: UIScreen.screenHeight/2)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .navigationBarBackButtonHidden(true)
            .background(RadialGradient(colors: [gradientColor, gradientColor.opacity(0.8), gradientColor], center: .center, startRadius: 100, endRadius: UIScreen.screenWidth - 150))
            .onAppear {
                gradientColor = pokemon.types![0].type.typeColor
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigation) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                ToolbarItemGroup {
                    
                    Button {
                        
                        // add function to add to favourites
                        let newFavPokemon = pokemon
//                        favPokemon.listPokemons.map { item in
//                            if item == newFavPokemon {
//                                print("already added to fav")
//                            } else {
//                                print("added to fav")
//                                return favPokemon.listPokemons.append(newFavPokemon)
//                            }
//                        }
                        favPokemon.listPokemons.append(newFavPokemon)
                    } label: {
                        //                        Label("Fav", systemImage: "star")
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        print("add to team")
                        
                        // add to team function to be added here
                        if (teamBuilder.teamPokemons.count < 6) {
                            let newTeamPokemon = pokemon
                            teamBuilder.teamPokemons.append(newTeamPokemon)
                        } else {
                            print("already have 6 members")
                        }
                        
                    } label: {
                        Image(systemName: "person.fill.questionmark")
                            .foregroundColor(.white)
                    }

                }
            })
        }
    }
    // funcs here
    func addPokemonToFav() {
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(pokemon)
            
            UserDefaults.standard.set(data, forKey: "favPokemon")
            
        } catch {
            print("unable to encode pokemon data")
        }
    }
    
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []), favPokemon: FavouritePokemons(), teamBuilder: TeamBuilderViewModel())
    }
}
