//
//  GenerationsView.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI

struct GenerationsView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("gen View")
            }
        }
        .background(Color(red: 237/255, green: 219/255, blue: 192/255))
        .cornerRadius(20, corners: .topLeft)
        .cornerRadius(20, corners: .topRight)
        .ignoresSafeArea()
    }
}

struct GenerationsView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationsView()
    }
}
