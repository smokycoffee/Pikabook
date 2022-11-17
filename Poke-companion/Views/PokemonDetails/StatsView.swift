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
                            Text(stats.stat.name)
                                .font(.system(.caption))
                                .frame(width: UIScreen.screenWidth / 4, alignment: .trailing)

                            BarChartCell(value: CGFloat(stats.baseStat!), barColor: .green)
                                .frame(alignment: .leading)
                        }
                    }
                }
            }
            .frame(alignment: .leading)
            .padding(.top, 10)
            .padding(.horizontal)
        }
//        .frame(maxHeight: .infinity)
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: []))
    }
}
