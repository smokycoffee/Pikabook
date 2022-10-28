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

    var body: some View {
            VStack {
                Group {
                    Text(pokemon.name)
                        .padding(.top, 60)
                        .font(.system(.largeTitle))
                    Text(String(pokemon.id))
                    
                    CachedAsyncImage(url: URL(string: pokemon.sprites?.other?.officialArtwork?.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                                .padding(.top, 20)
                        case .success(let image):
                            image
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding(.top, 20)
                        case .failure:
                            Image(systemName: "questionmark")
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text("Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.")
                        .multilineTextAlignment(.center)
                        .padding()
                } // Group
                
                PokemonControlTabsView(pokemon: pokemon)
                
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // nav back
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
    }
}

struct PokemonControlTabsView: View {
    
    var pokemon: Pokemon
    
    @State var index = 1
    @State var offset: CGFloat = UIScreen.main.bounds.width
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            AppBar(index: self.$index, offset: self.$offset)
            
            GeometryReader { g in
                HStack(spacing: 0) {
                    
                    PokemonAboutDescriptionView(pokemon: pokemon)
                        .frame(width: g.frame(in: .global).width)
                    
                    PokemonStatsView()
                        .frame(width: g.frame(in: .global).width)
                    
                    PokemonMovesView()
                        .frame(width: g.frame(in: .global).width)
                    
                }
                .offset(x: self.offset - (self.width))
                .highPriorityGesture(DragGesture()
                    .onEnded({ (value) in
                        if value.translation.width > 50 { // min drag distance
                            print("right")
                            self.changeView(left: false)
                        }
                        if -value.translation.width > 50 {
                            print("left")
                            self.changeView(left: true)
                        }
                    })
                )
                
            }
        }
        .animation(.default, value: offset)
//        .edgesIgnoringSafeArea(.all)
    }
    
    func changeView(left: Bool) {
        if left {
            if self.index != 3 {
                self.index += 1
            }
        } else {
            if self.index != 1 {
                self.index -= 1
            }
        }
        
        if self.index == 1 {
            self.offset = self.width
        }
        else if self.index == 2 {
            self.offset = 0
        }
        else if self.index == 3 {
            self.offset = -self.width
        }
        // change the width based on the size of the tabs...
    }
}

struct PokemonAboutDescriptionView: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                HStack {
                    
                    VStatLayout(bodyType: 50, placeholder: "Weight")
                    
                    Spacer()
                    
                    Capsule()
                        .frame(width: 2, height: 35)
                        .foregroundColor(.white)
                    
                    Spacer()
//                    ForEach(pokemon.types!, id: \.self) { i in
//                        Text(i.type.name)
//                            .padding(.horizontal, 2)
//                            .padding(.vertical, 2)
//                            .foregroundColor(.white)
//                            .font(.system(.body, design: .default, weight: .medium))
//                            .background(i.type.typeColor)
//                            .cornerRadius(5)
//                    }
                    Text("types here")
                    Spacer()
                    Capsule()
                        .frame(width: 2, height: 35)
                        .foregroundColor(.white)
                    Spacer()
                    VStatLayout(bodyType: 50, placeholder: "Height")
                    
                }
                .frame(height: 35)
                
                HStatLayout(typeTitle: "Species:", assignment: "Fire Pokemon", titleWidth: 70)
                    .padding(.vertical, 2)
                    .padding(.top, 10)
                
                HStatLayout(typeTitle: "Ability:", assignment: "Swish Swish", titleWidth: 70)
                    .padding(.vertical, 2)
                
                HStatLayout(typeTitle: "Encounters:", assignment: "Kanto", titleWidth: 100)
                    .padding(.vertical, 2)
                
                Spacer()
                
                Text("Evolutions:")
                    .padding(.bottom, 5)
                Text("Evolutions images here")
                
                Spacer()
                
            }
            .padding()
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
    }
}

struct PokemonStatsView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Stats View")
            }
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
    }
}

struct PokemonMovesView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("pokemon moves View")
            }
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
    }
}

struct PokemonGenerationView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("gen View")
            }
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
    }
}

struct AppBar: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    
                    self.index = 1
                    self.offset = self.width
                    
                } label: {
                    
                    VStack(spacing: 8) {
                        HStack(spacing:12) {
                            Image("person")
                                .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.7))
                            Text("About")
                                .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.7))
                        }
                        Capsule()
                            .fill(self.index == 1 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button {
                    self.index = 2
                    self.offset = 0
                } label: {
                    VStack(spacing: 8) {
                        HStack(spacing:12) {
                            Image("person")
                                .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.7))
                            Text("Stats")
                                .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.7))
                        }
                        Capsule()
                            .fill(self.index == 2 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button {
                    self.index = 3
                    self.offset = -self.width
                } label: {
                    VStack(spacing: 8) {
                        HStack(spacing:12) {
                            Image("person")
                                .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.7))
                            Text("Moves")
                                .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.7))
                        }
                        Capsule()
                            .fill(self.index == 3 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
            } // HStack end
        }
        .padding(.top, 15)
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(Color(red: 183/255, green: 62/255, blue: 62/255))
    }
}

struct VStatLayout: View {
    
    let bodyType: Int
    let placeholder: String
    
    var body: some View {
        VStack {
            Text(String(bodyType))
                .font(.system(.title2, design: .rounded, weight: .semibold))
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
        HStack {
            Text(typeTitle)
                .font(.system(.body, design: .default, weight: .bold))
                .frame(width: titleWidth, alignment: .leading)
            Text(assignment) // change this
                .font(.system(.body, design: .default, weight: .regular))
        }
    }
}


struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []))
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
