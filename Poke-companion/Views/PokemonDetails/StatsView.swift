//
//  PokemonStatsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Stats View")
            }
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
