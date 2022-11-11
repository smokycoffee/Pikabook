//
//  ControlTabsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI

struct ControlTabsView: View {
    var pokemon: Pokemon
    
    @State var index = 1
    @State var offset: CGFloat = UIScreen.main.bounds.width
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            TabsAppBar(index: self.$index, offset: self.$offset)
            
            GeometryReader { g in
                HStack(spacing: 0) {
                    
                    AboutDescriptionView(pokemon: pokemon)
                        .frame(width: g.frame(in: .global).width)
                    
                    StatsView()
                        .frame(width: g.frame(in: .global).width)
                    
                    MovesView()
                        .frame(width: g.frame(in: .global).width)
                    
                }
                .offset(x: self.offset - (self.width))
                .highPriorityGesture(DragGesture()
                    .onEnded({ (value) in
                        if value.translation.width > 50 { // min drag distance
                            self.changeView(left: false)
                        }
                        if -value.translation.width > 50 {
                            self.changeView(left: true)
                        }
                    })
                )
                
            }
        }
        .animation(.default, value: offset)
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

struct ControlTabsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlTabsView(pokemon: Pokemon(id: 1, name: "Charizard", baseExperience: 50, height: 20, isDefault: false, order: 1, weight: 1, abilities: [], forms: [], gameIndices: [], heldItems: [], locationAreaEncounters: "Kanto", moves: [], species: nil, sprites: nil, stats: [], types: [], pastTypes: [])).previewLayout(.sizeThatFits)
    }
}
