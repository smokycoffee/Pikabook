//
//  PokemonTypeCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import SwiftUI
import CachedAsyncImage
import ActivityIndicatorView

struct PokemonDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var pokemon: Pokemon
    
    @State var gradientColor: Color = .gray
    @ObservedObject var favPokemon: FavouritePokemons
    @ObservedObject var teamBuilder: TeamBuilderViewModel
    @State var favourited: Bool = false

    @State var selectedPokemon: Pokemon?
    @State private var showingAlertFav = false
    @State private var showingAlertTeam = false
    @State private var selectedShow: Pokemon?
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var imageUrl = ""
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    
    @ObservedObject var pokemonSpeciesVM: PokemonSpeciesViewModel
    
//    @State var pokemons: [Pokemon]?
    
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
                        
                        CachedAsyncImage(url: URL(string: imageUrl), urlCache: .imageCache) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                            case .failure:
                                Image(systemName: "questionmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    
                        Text(pokemonSpeciesVM.flavorText)
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
            .alert(item: $selectedShow) { pokemon in
                Alert(title: Text(alertTitle), message: Text(alertMessage))
            }
            .ignoresSafeArea(.all, edges: .all)
            .navigationBarBackButtonHidden(true)
            .background(RadialGradient(colors: [gradientColor, gradientColor.opacity(0.9), gradientColor], center: .center, startRadius: 100, endRadius: UIScreen.screenWidth - 150).opacity(0.7))
            .onAppear {
                gradientColor = pokemon.types![0].type.typeColor
                //                favPokemon.loadAllFavourites()
                pokemonSpeciesVM.fetchPokemonSpecies(for: pokemon.species?.url ?? "ss")

                selectedPokemon = pokemon
                predicate()
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
                        if favPokemon.listPokemons.contains(selectedPokemon!) {
                            selectedShow = pokemon
                            alertTitle = "You've already added! 🙈"
                            alertMessage = "\(pokemon.name.capitalizingFirstLetter()), says no to duplicates!"
                            return
                            
                        } else {
                            selectedShow = pokemon
                            alertTitle = "To Favourites 🚀!"
                            alertMessage = "Duplicated \(pokemon.name.capitalizingFirstLetter()) in favourites!"

                            let newFavPokemon = pokemon
                            favPokemon.listPokemons.append(newFavPokemon)
                        }
                        // add function to add to favourites
                } label: {
                    //                        Label("Fav", systemImage: "star")
                    Image(systemName: favourited ? "star" : "star.fill")
                        .foregroundColor(.white)
                }
                
                Button {
                    print("add to team")
                    
                    // add to team function to be added here
                    if (teamBuilder.teamPokemons.count < 6) {
                        if teamBuilder.teamPokemons.contains(selectedPokemon!) {
                            
                            selectedShow = pokemon
                            alertTitle = "You've already add me!!"
                            alertMessage = "\(pokemon.name), exists in Team!"
                        } else {
                        
                            let newTeamPokemon = pokemon
                            teamBuilder.teamPokemons.append(newTeamPokemon)
                            
                            selectedShow = pokemon
                            alertTitle = "Added to Team 🤘!"
                            alertMessage = "\(pokemon.name.capitalizingFirstLetter()), I choose you! 🤌"
                        }
                    } else {
                        
                        selectedShow = pokemon
                        alertTitle = "Team is complete!!"
                        alertMessage = "6 Pokemons MAX, don't be greedy! 💀"
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
    func predicate() {
        if pokedexImageSetting.imageOrder == .Original {
            imageUrl = pokemon.sprites!.frontDefault
        } else if pokedexImageSetting.imageOrder == .Official {
            imageUrl = (pokemon.sprites?.other?.officialArtwork?.frontDefault)!
        } else if pokedexImageSetting.imageOrder == .Futuristic {
            imageUrl = (pokemon.sprites?.other?.home?.frontDefault)!
        }
    }
    
    
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []), favPokemon: FavouritePokemons(), teamBuilder: TeamBuilderViewModel(), favourited: false, pokemonSpeciesVM: PokemonSpeciesViewModel()).environmentObject(PokedexImageSetting())
    }
}
