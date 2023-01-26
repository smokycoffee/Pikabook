//
//  MovesCellView.swift
//  Poke-companion
//
//  Created by Tsenguun on 30/12/22.
//

import SwiftUI

struct MovesCellView: View {
    let pokemon: Move?
    var body: some View {
        HStack {
            Text(pokemon?.move.name.capitalized.replacingOccurrences(of: "-", with: " ") ?? "nil")
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack(alignment:.trailing) {
                Text("Requirement level \((pokemon?.versionGroupDetails![0].levelLearnedAt)!)")
                Text("with \((pokemon?.versionGroupDetails![0].moveLearnMethod.name)!)")
            }
            .font(.system(.subheadline, design: .rounded))
            .opacity(0.8)
        }
        .foregroundColor(.black)
        .padding()
        .background(Color(.random).opacity(0.4))
        .cornerRadius(10)
    }
}

struct MovesCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovesCellView(pokemon: nil)
    }
}


