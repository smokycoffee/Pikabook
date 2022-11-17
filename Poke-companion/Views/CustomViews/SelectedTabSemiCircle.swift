//
//  SelectedTab.swift
//  Poke-companion
//
//  Created by Tsenguun on 11/11/22.
//

import SwiftUI

struct SelectedTabSemiCircle: View {
    var highlighted: Color
    
    var body: some View {
        Circle()
            .trim(from: 0.5, to: 1)
            .stroke(highlighted, lineWidth: 30)
            .frame(maxWidth: 50)
            .offset(y: 20)
    }
}

struct SelectedTabSemiCircle_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTabSemiCircle(highlighted: .white)
    }
}
