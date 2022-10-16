//
//  ErrorAlerts.swift
//  Poke-companion
//
//  Created by Tsenguun on 15/10/22.
//

import Foundation

struct ErrorAlerts: Error, Identifiable {
    let id = UUID()
    let title =  "Error"
    let message = "There are some errors in previous action."
}
