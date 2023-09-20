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
    @State private var scene: GameScene?
    @State private var imageName = "ic_pause"
    @State private var isGamePaused = false
    @State private var isPresented: Bool = false
    @State private var bestScore: Int = 0
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        GeometryReader { proxy in
            ZStack(){
                ZStack(alignment: .topTrailing) {
                    if let _ = scene{
                        SpriteView(scene: scene!).frame(width: proxy.size.width, height: proxy.size.height)
                    }
                    HStack(){
                        Text("Points:").font(.system(size: 25)).foregroundColor(Color.white)
                        
                        Text("\(points)").font(.system(size: 25)).foregroundColor(Color.white)
                    }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 10))
                }.onAppear{
                    scene = GameScene(size: proxy.size)
                    scene?.gameDelegate = self
                }
                
                ZStack(){
                    HStack(){
                        Image(imageName).imageScale(.large).onTapGesture {
                            onPauseClicked()
                        }
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)).frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                
                if isPresented{
                    DialogView(playerScore: $points, bestScore: $bestScore, isPresented: $isPresented)
                }
                
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
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                if !isGamePaused{
                    pauseGame()
                }
            }
        }
    }
}

extension GameView{
    private func onPauseClicked(){
        if isGamePaused{
            resumeGame()
        }else{
            pauseGame()
        }
    }
    
    private func pauseGame(){
        isGamePaused = true
        scene?.pause()
        imageName = "ic_resume"
    }
    
    private func resumeGame(){
        isGamePaused = false
        scene?.resume()
        imageName = "ic_pause"
    }
}
extension GameView : GameProtocol{
    func onGetPoints(points: Int) {
        self.points += points
    }
    
    func onGameOver() {
        scene?.pause()
        showGameOverDialog()
        saveScore()
    }
    
    private func showGameOverDialog(){
        bestScore =  UserDefulatManager.INSTANCE.getHighScore()
        isPresented = true
    }
    
    private func saveScore(){
        let highScore = UserDefulatManager.INSTANCE.getHighScore()
        if (points > highScore) {
            UserDefulatManager.INSTANCE.saveHighScore(score: points)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
