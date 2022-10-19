//
//  Extensions.swift
//  Poke-companion
//
//  Created by Tsenguun on 20/10/22.
//

import Foundation


extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
