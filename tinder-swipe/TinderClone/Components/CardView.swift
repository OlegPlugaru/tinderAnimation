//
//  CardView.swift
//  TinderClone
//
//  Created by Franck-Stephane Ndame Mpouli on 19/02/2021.
//

import SwiftUI
import Photos

struct CardView: View {
    @State var card: Card
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: card.image())
                //.resizable()
                
                .frame(maxWidth: 400, maxHeight: 500)
                .scaledToFill()
                
                
                
            //    .clipped()
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 - 1))
                Spacer()
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 * -1 - 1))
            }
        }
     
        .cornerRadius(8)
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        .gesture (
            DragGesture()
                .onChanged { value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
                .onEnded { value in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x < -100:
                            card.x  = -500; card.degree = -12
                        default:
                            card.x = 0; card.y = 0
                        }
                    }
                }
        )
    }
}

extension Card {
    func image() -> UIImage {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        var resultImage: UIImage?
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: options) { image, _ in
            resultImage = image
        }
        
        return resultImage ?? UIImage()
    }
}
