//
//  SettingsAboutView.swift
//  Poke-companion
//
//  Created by Tsenguun on 25/1/23.
//

import SwiftUI

struct SettingsAboutView: View {
    var body: some View {
            ScrollView {
                VStack {
                    Text("Pokébook")
                        .font(.system(.title, design: .default, weight: .bold))
                        .foregroundColor(.primary)
                    Divider()
                    //            Text("So, this is my power… but what is my purpose?” — Mewtwo")
                    Text(" Humans may have created me, but they will never enslave me. This cannot be my destiny. - Mewtwo")
                        .foregroundColor(.secondary)
                    Divider()
                    HStack {
                        Text("Features and guide")
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    Divider()
                    Group {
                        Text("I built Pokébook aimed to be one stop partner to look at stats whilst you're playing pokemon regardless of any pokemon generation. (much features to implement to achieve it 😆)")
                            .multilineTextAlignment(.center)
                        
                        Divider()
                        
                        HStack {
                            Text("• ")
                            Text("**Pokedex** - Filter by generations on top right \(Image(systemName: "line.3.horizontal")) button as well as filtering by searching current list. \n green button to scroll back to top, bottom right")
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        HStack {
                            Text("• ")
                            Text("**Pokemon details page** - Swipe right and left to move between about, stats and moves. \n\(Image(systemName: "star.fill")) button to add to favourites, \(Image(systemName: "person.fill.questionmark")) to add to team!")
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        HStack {
                            Text("• ")
                            Text("**Team** - Tap pokemon inside grid or **SUPER** long press to 'delete' pokemone! \n tap **medium** duration to drag and drop to realign to oder your team as you WISH! 😎 🆒")
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        HStack {
                            Text("• ")
                            Text("**Settings** - Change image style for pokedex and team via the picker in settings! and rate the app! 😜")
                            Spacer()
                        }
                        .padding(.top, 10)
                        
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

struct SettingsAboutView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAboutView()
    }
}
