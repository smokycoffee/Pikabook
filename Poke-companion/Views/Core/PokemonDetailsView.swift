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

    var body: some View {
            VStack {
                Group {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 5)
                    Text(pokemon.name.capitalizingFirstLetter())
//                        .padding(.top, 60)
                        .font(.system(.largeTitle, design: .rounded, weight: .medium))
                    Text("#" + String(pokemon.id))
                        .font(.system(.body, design: .rounded, weight: .regular))
                    
                    CachedAsyncImage(url: URL(string: pokemon.sprites?.other?.officialArtwork?.frontDefault ?? "ss"), urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                                .padding(.top)
                        case .success(let image):
                            image
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding(.top)
                        case .failure:
                            Image(systemName: "questionmark")
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                                .padding(.top)
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
            }
            .overlay(content: {
                HStack {
                    Spacer()

                    VStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.down.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                        Spacer()
                    }
                }
            })
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
            .background(RadialGradient(colors: [gradientColor, gradientColor.opacity(0.6), gradientColor], center: .center, startRadius: 100, endRadius: UIScreen.screenWidth - 150))
            .onAppear {
                gradientColor = pokemon.types![0].type.typeColor
            }
    }
}

struct SelectedTab: View {
    var highlighted: Color
    
    var body: some View {
        Circle()
            .trim(from: 0.5, to: 1)
            .stroke(highlighted, lineWidth: 30)
            .frame(width: 50)
            .offset(y: 20)
    }
}

struct AppBar: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var width = UIScreen.main.bounds.width
    var tempColor = Color(red: 183/255, green: 62/255, blue: 62/255)

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    
                    self.index = 1
                    self.offset = self.width
                    
                } label: {
                    
                    ZStack {
                        SelectedTab(highlighted: self.index == 1 ? tempColor : Color.clear)
                        VStack(spacing: 8) {
                            HStack(spacing:12) {
                                Text("About")
                                    .foregroundColor(self.index == 1 ? .white : Color.white)
                                    .fontWeight(.semibold)
                            }
//                            Capsule()
//                                .fill(self.index == 1 ? Color.white : Color.clear)
//                                .frame(height: 4)
                        }
                    }
                }
                Spacer()

                
//                Circle()
//                    .trim(from: 0.5, to: 1)
//                    .stroke(.purple, lineWidth: 20)
//                    .frame(width: 40)
//
//
                Button {
                    self.index = 2
                    self.offset = 0
                } label: {
                    ZStack {
                        SelectedTab(highlighted: self.index == 2 ? tempColor : Color.clear)
                        VStack(spacing: 8) {
                            HStack(spacing:12) {
    //                            Image("person")
    //                                .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.7))
                                Text("Stats")
                                    .foregroundColor(self.index == 2 ? .white : Color.white)
                                    .fontWeight(.semibold)
                            }
//                            Capsule()
//                                .fill(self.index == 2 ? Color.white : Color.clear)
//                                .frame(height: 4)
                        }
                    }
                }
                Spacer()

                Button {
                    self.index = 3
                    self.offset = -self.width
                } label: {
                    ZStack {
                        SelectedTab(highlighted: self.index == 3 ? tempColor : Color.clear)
                        VStack(spacing: 8) {
                            HStack(spacing:12) {
    //                            Image("person")
    //                                .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.7))
                                Text("Moves")
                                    .foregroundColor(self.index == 3 ? .white : Color.white)
                                    .fontWeight(.semibold)
                            }
//                            Capsule()
//                                .fill(self.index == 3 ? Color.white : Color.clear)
//                                .frame(height: 4)
                        }
                    }
                }

            } // HStack end
            .padding(.horizontal)
        }
//        .padding(.top, 15)
        .padding(.horizontal)
//        .background(Color(red: 183/255, green: 62/255, blue: 62/255))
//        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
        .background(.clear)
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
                    .font(.system(.title3, design: .rounded, weight: .semibold))
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
