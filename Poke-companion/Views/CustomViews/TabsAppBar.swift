//
//  TabsAppBar.swift
//  Poke-companion
//
//  Created by Tsenguun on 12/11/22.
//

import SwiftUI

struct TabsAppBar: View {
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
                        SelectedTabSemiCircle(highlighted: self.index == 1 ? tempColor : Color.clear)
                        VStack(spacing: 8) {
                            HStack(spacing:12) {
                                Text("About")
                                    .foregroundColor(self.index == 1 ? .white : Color.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    self.index = 2
                    self.offset = 0
                } label: {
                    ZStack {
                        SelectedTabSemiCircle(highlighted: self.index == 2 ? tempColor : Color.clear)
                        VStack(spacing: 8) {
                            HStack(spacing:12) {
                                Text("Stats")
                                    .foregroundColor(self.index == 2 ? .white : Color.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                Spacer()
                
                Button {
                    self.index = 3
                    self.offset = -self.width
                } label: {
                    ZStack {
                        SelectedTabSemiCircle(highlighted: self.index == 3 ? tempColor : Color.clear)
                        VStack(spacing: 8) {
                            HStack(spacing:12) {
                                Text("Moves")
                                    .foregroundColor(self.index == 3 ? .white : Color.white)
                                    .fontWeight(.semibold)
                            }
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

//struct TabsAppBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabsAppBar(index: <#Binding<Int>#>, offset: <#Binding<CGFloat>#>)
//    }
//}
