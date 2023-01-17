//
//  DropViewDelegate.swift
//  Poke-companion
//
//  Created by Tsenguun on 1/1/23.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    var pokemon: Pokemon
    var pokemonData: TeamBuilderViewModel

    
    func performDrop(info: DropInfo) -> Bool {
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        let fromIndex = pokemonData.teamPokemons.firstIndex { (grid) -> Bool in
            return grid.id == pokemonData.currentPokemon?.id
        } ?? 0
        
        let toIndex = pokemonData.teamPokemons.firstIndex { (grid) -> Bool in
            return grid.id == self.pokemon.id
        } ?? 0
        
        if fromIndex != toIndex{
            withAnimation(.default){
                let fromGrid = pokemonData.teamPokemons[fromIndex]
                pokemonData.teamPokemons[fromIndex] = pokemonData.teamPokemons[toIndex]
                pokemonData.teamPokemons[toIndex] = fromGrid
            }
        }
    }

    // setting Action as Move...
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}


