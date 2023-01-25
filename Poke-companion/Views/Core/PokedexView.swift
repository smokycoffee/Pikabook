//
//  PokedexView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI
import ActivityIndicatorView

struct PokedexView: View {
    
    @StateObject private var pokemonVM = PokedexViewModel()
    @StateObject private var pokemonSpeciesVM = PokemonSpeciesViewModel()
    
    @State var selectedPokemon: Pokemon?

    @State var loaded = false
    
    @State var testPokemonList = [Pokemon]()
    @State private var searchText = ""
    
    @State private var selectedPokemonGeneration = GenerationsType.generationOne
    
    @EnvironmentObject var selectedGenerationSetting: GenerationsTypeSetting
    
    @State var loadingAnimation = false
    @State var title = ""
    
    var pokedexData: [Pokemon] {
        if searchText.isEmpty {
            return pokemonVM.pokemonListArray
        } else {
            return pokemonVM.searchResults
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                switch pokemonVM.state {
                case .isLoading:
                    ActivityIndicatorView(isVisible: $loadingAnimation, type: .arcs(count: 3, lineWidth: 2))
                        .foregroundColor(Color(UIColor.random))
                        .frame(width: 100, height: 100, alignment: .center)
                case .done:
                    List(pokedexData, id: \.id) { poke in
                        ZStack {
                            PokedexCellView(pokemon: poke)
                                .environmentObject(PokemonSpeciesViewModel())
                                .onTapGesture {
                                    self.selectedPokemon = poke
                                }
                            NavigationLink(value: poke) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .overlay(content: {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Button {
                                    withAnimation(.easeInOut) {
                                        proxy.scrollTo(pokedexData[0].id)
                                    }
                                } label: {
                                    Image(systemName: "chevron.up.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.green)
                                }
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                                .padding(.bottom, 15)
                            }
                        }
                    })
                    .listStyle(.inset)
                    .sheet(item: $selectedPokemon, content: { poke in
                        PokemonDetailsView(pokemon: poke, favPokemon: FavouritePokemons(), teamBuilder: TeamBuilderViewModel(), pokemonSpeciesVM: PokemonSpeciesViewModel())
                            .presentationDetents([.large])
                    })
                    .navigationTitle(title)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Picker(selection: $selectedPokemonGeneration, label: Text("Gens")) {
                                    ForEach(GenerationsType.allCases, id: \.self) {
                                        imageType in
                                        Text(imageType.text)
                                    }
                                }
                                .onChange(of: selectedPokemonGeneration) { newValue in
                                    pokemonVM.pokemonListArray = []
                                    selectedGenerationSetting.genOrder = newValue
                                    predicate()
                                    pokemonVM.testPokemons()
                                }
                            } label: {
                                Label("gen", systemImage: "line.3.horizontal")
                                    .foregroundColor(.red.opacity(0.7))
                            }
                        }
                    })
                    .searchable(text: $searchText)
                    .onChange(of: searchText) { searchText in
                        pokemonVM.searchResults = pokemonVM.pokemonListArray.filter({ index in
                            index.name.lowercased().contains(searchText.lowercased())
                        })
                    }
                    .animation(.default, value: searchText)
                }// switch end
                
            }
        }
        .onAppear {
            predicate()
            if loaded == false {
                pokemonVM.testPokemons()
                loaded = true
                //                predicate()
            }
            self.selectedPokemonGeneration = self.selectedGenerationSetting.genOrder
            self.loadingAnimation = true
        }
    }
    // func , pokemonListArray = [Pokemon]()
    func predicate() {
        if selectedGenerationSetting.genOrder == .generationOne {
            pokemonVM.generationLimit = 151
            pokemonVM.offsetLimit = 0
            title = "1st gen pokemons"
        } else if selectedGenerationSetting.genOrder == .generationTwo {
            pokemonVM.generationLimit = 100
            pokemonVM.offsetLimit = 151
            title = "2nd gen pokemons"
        } else if selectedGenerationSetting.genOrder == .generationThree {
            pokemonVM.generationLimit = 135
            pokemonVM.offsetLimit = 251
            title = "3rd gen pokemons"
            
        } else if selectedGenerationSetting.genOrder == .generationFour {
            pokemonVM.generationLimit = 107
            pokemonVM.offsetLimit = 386
            title = "4th gen pokemons"
            
        } else if selectedGenerationSetting.genOrder == .generationFive {
            pokemonVM.generationLimit = 156
            pokemonVM.offsetLimit = 493
            title = "5th gen pokemons"
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
            .environmentObject(GenerationsTypeSetting())
    }
}
