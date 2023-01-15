//
//  PokemonStatsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI
import Charts

struct StatsView: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                
                ForEach(pokemon.stats) { stats in
                    VStack {
                        HStack {
                            Text(stats.stat.name.capitalized.replacingOccurrences(of: "-", with: " "))
                                .font(.system(.subheadline))
                                .frame(width: UIScreen.screenWidth / 3, alignment: .trailing)
                                .foregroundColor(.black)

                            BarChartCell(value: CGFloat(stats.baseStat!), barColor: .green.opacity(0.7))
                                .frame(alignment: .leading)
                        }
                    }
                }
            }
            .frame(alignment: .leading)
            .padding(.top, 10)
            .padding(.horizontal)
        }
        .frame(minHeight: 1000)
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
        .cornerRadius(20, corners: .topLeft)
        .cornerRadius(20, corners: .topRight)
        .ignoresSafeArea()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []))
    }
}
