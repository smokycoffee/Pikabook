//
//  UpcomingFeaturesAboutView.swift
//  Poke-companion
//
//  Created by Tsenguun on 26/1/23.
//

import SwiftUI

struct UpcomingFeaturesAboutView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Planned Features")
                    .font(.system(.title, design: .default, weight: .bold))
                    .foregroundColor(.primary)
                Divider()
                //            Text("So, this is my power… but what is my purpose?” — Mewtwo")
                Text("Pokébook right now am at its infant state, I plan to further build and increase complexity to ultimately be a one stop partner for pokemon games or just browsing through. - Developer")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                Divider()
                HStack {
                    Text("Pokébook")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .frame(alignment: .leading)
                    Spacer()
                }
                Divider()
                Group {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("• - to add pokemons from generation 6th to 9th.")
                                .padding(.top, 10)
                            Text("• - fix evolution chain bug. either it loads in wrong order or it gets frozen. To move to clicked pokemon in evolution chain")
                                .padding(.top, 10)
                            Text("• - add details to moves, learned at level or via external materials")               .padding(.top, 10)
                            Text("• - pokemon weakness and strengths")
                                .padding(.top, 10)
                            Text("• - team details with ui layout ")
                                .padding(.top, 10)
                            Text("• - locations on where to encounter and encounter methods etc ")                    .padding(.top, 10)
                            Text("• - Feedback form to get users feedback and opinions how to further improve app")    .padding(.top, 10)
                            Spacer()
                        }
                        .padding()
                        .padding(.top, 10)
                    }
                }
                .font(.system(.subheadline, design: .rounded, weight: .regular))
                .frame(alignment: .leading)
                .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding(.horizontal)
        }

    }
}

struct UpcomingFeaturesAboutView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingFeaturesAboutView()
    }
}
