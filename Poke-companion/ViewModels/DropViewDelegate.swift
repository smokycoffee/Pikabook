//
//  DropViewDelegate.swift
//  Poke-companion
//
//  Created by Tsenguun on 1/1/23.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    
    func performDrop(info: DropInfo) -> Bool {
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        
    }
    
    // setting Action as Move...
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}


