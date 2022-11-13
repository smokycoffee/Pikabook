//
//  BarChartCell.swift
//  Poke-companion
//
//  Created by Tsenguun on 13/11/22.
//

import SwiftUI

struct BarChartCell: View {
    
    var value: CGFloat
    var barColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(.gray.opacity(0.6))
                    .frame(width: 100 * 2, height: 10)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(barColor)
                    .frame(width: value, height: 10)
            }
        }
        
    }
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        BarChartCell(value: 87 * 2, barColor: .blue)
//            .previewLayout(.sizeThatFits)
    }
}
