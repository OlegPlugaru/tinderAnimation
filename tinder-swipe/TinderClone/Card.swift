//
//  Person.swift
//  TinderClone
//
//  Created by Franck-Stephane Ndame Mpouli on 06/08/2020.
//

import SwiftUI
import Photos


struct Card: Identifiable {
    let id = UUID()
    let asset: PHAsset
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var degree: Double = 0.0
    
    static func fetchPhotos() -> [Card] {
        var cards: [Card] = []
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: options)
        fetchResult.enumerateObjects { asset, _, _ in
            cards.append(Card(asset: asset))
        }
        
        return cards
    }
}

