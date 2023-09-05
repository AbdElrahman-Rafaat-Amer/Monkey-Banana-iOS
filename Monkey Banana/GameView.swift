//
//  GameView.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 24/07/2023.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @State private var points = 0
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                let scene = GameScene(size: proxy.size)
                let _ = scene.gameDelegate = self
                SpriteView(scene: scene).frame(width: proxy.size.width, height: proxy.size.height)
                HStack(){
                    Text("Points:").font(.system(size: 25)).foregroundColor(Color.white)
                    
                    Text("\(points)").font(.system(size: 25)).foregroundColor(Color.white)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            }.frame(
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

extension GameView : GameProtocol{
    func onGetPoints(points: Int) {
        self.points += points
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
