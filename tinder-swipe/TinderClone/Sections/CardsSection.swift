//
//  CardsSection.swift
//  TinderClone
//
//  Created by Franck-Stephane Ndame Mpouli on 19/02/2021.
//

import SwiftUI

struct CardsSection: View {
    let cards = Card.fetchPhotos()
    
    var body: some View {
        ZStack {
            ForEach(cards.reversed()) { card in
                CardView(card: card)
            }
        }
        .padding(8)
        .zIndex(1.0)
    }
}
