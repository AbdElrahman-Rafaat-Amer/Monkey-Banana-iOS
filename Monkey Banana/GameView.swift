//
//  GameView.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 24/07/2023.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var body: some View {
        GeometryReader { proxy in
            
            VStack() {
                let scene = GameScene(size: proxy.size)
                SpriteView(scene: scene).frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(Color.green)
            .navigationBarHidden(true)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
