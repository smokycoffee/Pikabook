//
//  SettingsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI
import StoreKit
import WebKit

struct RandomQuotes {
    let quote: String
}

struct SettingsView: View {
    
    @State private var selectedOrderFavourites = PokedexImageType.Official
    @State private var selectedOrderTeam = PokedexImageType.Official
    @State private var selectedEvolutionImageOrder = PokedexImageType.Official
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    
    @Environment(\.requestReview) var requestReview
    
    var randomQuote: RandomQuotes!
    
    init() {
        self.randomQuote = randomQuotes.randomElement()
        }


    var body: some View {
            NavigationStack {
                Form {
                    Section(header: Text("SORT IMAGE"), footer: Text("Sort image preference for pokemon list and details as well as team images")) {
                        Picker(selection: $selectedOrderFavourites, label: Text("Pokedex Images")) {
                            ForEach(PokedexImageType.allCases, id: \.self) {
                                imageType in
                                Text(imageType.text)
                            }
                        }
                        .onChange(of: selectedOrderFavourites) { newValue in
                            self.pokedexImageSetting.imageOrder = newValue
                        }
                        Picker(selection: $selectedOrderTeam, label: Text("Team Images")) {
                            ForEach(PokedexImageType.allCases, id: \.self) {
                                imageType in
                                Text(imageType.text)
                            }
                        }
                        .onChange(of: selectedOrderTeam) { newValue in
                            self.pokedexImageSetting.teamImageOrder = newValue
                        }
                    }
                    
                    Section(header: Text("SUPPORT AND RESOURCES")) {
                        NavigationLink {
                            SettingsAboutView()
                        } label: {
                            Label("How to use the app (list of features).", systemImage: "questionmark.circle")
                                .foregroundColor(.primary)
                                .font(.system(size: 16))
                        }
                        Button {
                            requestReview()
                        } label: {
                            Label("Like it? Rate the app! Thank you 😊", systemImage: "link")
                                .foregroundColor(.primary)
                                .font(.system(size: 16))
                        }
                    }
                    
                    Section {
                        
                        NavigationLink {
                            WebView(url: "https://github.com/smokycoffee")
                        } label: {
                            Label("Follow me on github @smokycoffee", systemImage: "link")
                                .foregroundColor(.primary)
                                .font(.system(size: 16, weight: .bold))
                        }
                        
    //                    Label("Follow me on github @smokycoffee", systemImage: "link")
    //                        .foregroundColor(.primary)
    //                        .font(.system(size: 16, weight: .bold))
                        
                    } footer: {
                        Text("Disclaimer: this project is not public just yet :)")
                    }
                    
                    Section {
                        Text(randomQuote.quote)
                            .foregroundColor(.secondary)
                            .font(.system(.headline, design: .rounded, weight: .medium))
                            .padding(.horizontal, 30)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        
                    }
                    .listRowBackground(Color.clear)
                }
                
                .navigationTitle("Settings")
                .onAppear {
                    self.selectedOrderFavourites = self.pokedexImageSetting.imageOrder
                    self.selectedOrderTeam = self.pokedexImageSetting.teamImageOrder
                    self.selectedEvolutionImageOrder = self.pokedexImageSetting.evolutionChainOrderType
                }
            }.tint(.primary)

    }
    
    let randomQuotes = [RandomQuotes(quote: "There’s no sense in going out of your way to get somebody to like you. — Ash"),
                       RandomQuotes(quote: "We do have a lot in common. The same earth, the same air, the same sky. Maybe if we started looking at what’s the same, instead of looking at what’s different, well, who knows?” — Meowth"),
                       RandomQuotes(quote: "Make your wonderful dream a reality, and it will become your truth. — N"),
                       RandomQuotes(quote: "A wildfire destroys everything in its path. It will be the same with your powers unless you learn to control them.” — Giovanni"),
                       RandomQuotes(quote: "When you have lemons, you make lemonade; and when you have rice, you make rice balls. — Brock"),
                       RandomQuotes(quote: "Living is using time given to you. You cannot recall lost time. — NPC"),
                       RandomQuotes(quote: "That’s okay, Brock, you’ll find lots of other girls to reject you! — Ash"),
                       RandomQuotes(quote: "Even if you lose in battle, if you surpass what you’ve done before, you have bested yourself. — Marshall"),
                       RandomQuotes(quote: "I see now that the circumstances of one’s birth are irrelevant; it is what you do with the gift of life that determines who you are. - Mewtwo"),
                       RandomQuotes(quote: "Getting wrapped up in worries is bad for your body and spirit. That’s when you must short out your logic circuits and reboot your heart.” — Elesa"),
                       RandomQuotes(quote: "It’s more important to master the cards you’re holding than to complain about the ones your opponent was dealt. — Grimsley"),
                       RandomQuotes(quote: "Strong Pokémon. Weak Pokémon. That is only the selfish perception of people. Truly skilled trainers should try to win with all their favorites. — Karen"),
                       RandomQuotes(quote: "The more wonderful the meeting, the sadder the parting. — Looker"),
                       RandomQuotes(quote: "Even If we don’t understand each other, that’s not a reason to reject each other. There are two sides to any argument. Is there one point of view that has all the answers? Give it some thought. — Alder"),
                       RandomQuotes(quote: "Me, give up? No way! — Ash"),
                       RandomQuotes(quote: "You see, sometimes friends have to go away, but a part of them stays behind with you. — Ash"),
                       RandomQuotes(quote: "A Caterpie may change into a Butterfree, but the heart that beats inside remains the same. — Brock"),
                       RandomQuotes(quote: "The important thing is not how long you live. It’s what you accomplish with your life.” — Grovyle"),
                       RandomQuotes(quote: "Do you always need a reason to help somebody? — Ash"),
                       RandomQuotes(quote: "I’ll use my trusty frying pan… as a drying pan! — Brock"),
                       RandomQuotes(quote: "To them, this is just one more challenge. They follow their hearts. That is what sets them apart, and will make them Pokémon Master — Miranda"),
                       RandomQuotes(quote: "I’m totally unprepared to deal with life’s realities. — Meowth"),
                       RandomQuotes(quote: "Don’t you know that love is the most important thing in the whole world? — Misty"),
                       RandomQuotes(quote: "If there is someone in this world who understands you, it feels like that person is right beside you. Even if you’re as far apart as the end of the land and top of the sky. — Giallo"),
                       RandomQuotes(quote: "Everybody makes a wrong turn once in a while. — Ash"),
                       RandomQuotes(quote: "“Physical wounds can be treated without much difficulty, but emotional wounds are not so easy to heal. — N"),
                       RandomQuotes(quote: "Take charge of your destiny. — Rayquaza"),
                       RandomQuotes(quote: "Man has plenty to learn from nature and from Pokémon. — Mr. Briney"),

    ]
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(PokedexImageSetting())
    }
}

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
