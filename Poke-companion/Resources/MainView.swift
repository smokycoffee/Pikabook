//
//  ContentView.swift
//  Poke-companion
//
//  Created by Tsenguun on 14/10/22.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 0
    @EnvironmentObject var pokedexImageSetting: PokedexImageSetting
    
    var body: some View {
        TabView(selection: $selection) {
            PokedexView()
                .tabItem {
                    Image("pokemon")
                    Text("Pokédex")
                }
                .tag(0)
            FavouritesView()
                .tabItem {
                    Label("Fav", systemImage: "star")
                        .foregroundColor(.white)
                }
                .tag(1)
            TeamBuilderView()
                .tabItem {
                    Image(systemName: "person.fill.questionmark")
                        .backgroundStyle(.white)
                    Text("Team")
                }
                .tag(2)
            SettingsView().environmentObject(self.pokedexImageSetting)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
                .accentColor(.white)
        }
//        .frame(height: 150)
        .accentColor(Color(red: 219/255, green: 200/255, blue: 172/255))
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(red: 183/255, green: 62/255, blue: 62/255, alpha: 1)
            appearance.shadowColor = .white
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(PokedexImageSetting())
    }
}
