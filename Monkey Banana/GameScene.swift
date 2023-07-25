//
//  GameScene.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 24/07/2023.
//

import Foundation
import SpriteKit

class GameScene : SKScene{
    private let banana = SKSpriteNode(imageNamed: "ic_banana")
    private let ground = SKSpriteNode(imageNamed: "ic_ground")
    private let monkey = SKSpriteNode(imageNamed: "ic_monkey")
    
    override func didMove(to view: SKView) {
        monkey.setScale(0.4)
        addBackground()
        addBottomGround()
        addBanana()
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonkey),
                SKAction.wait(forDuration: 4.8)
            ])
        ))
    }
    
    private func addBackground(){
        let background = SKSpriteNode(imageNamed: "ic_jungle")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.size = size
        addChild(background)
    }
    
    private func addBottomGround(){
        ground.setScale(0.3)
        ground.position = CGPoint(x: frame.size.width / 2, y: 0)
        ground.size.width = size.width
        addChild(ground)
    }
    
    private func addBanana(){
        banana.setScale(0.25)
        let bananaX = size.width / 4
        let bananaY = banana.size.height/2 + ground.size.height/2
        banana.position = CGPoint(x: bananaX, y: bananaY)
        addChild(banana)
    }
    
    private func addMonkey(){
        let monkey = SKSpriteNode(imageNamed: "ic_monkey")
        monkey.setScale(0.4)
        let monkeyX = size.width
        let monkeyY = monkey.size.height/2 + ground.size.height/2
        let startPoint = CGPoint(x: monkeyX, y: monkeyY)
        monkey.position = startPoint
        addChild(monkey)
        
        let endPoint = CGPoint(x: -monkey.size.width/2, y: monkeyY)
        let distance = endPoint.distance(to: startPoint)
        
        
        let rockSpeed : CGFloat = 60
        let duration = TimeInterval(distance / rockSpeed)
        let moveAction = SKAction.move(to: endPoint, duration: duration)
        let removeAction = SKAction.removeFromParent()
        let runAction = SKAction.sequence([moveAction, removeAction])
        
        monkey.run(runAction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
    
        let bananaCurrentPosition = banana.position
        let targetPoint = CGPoint(x: bananaCurrentPosition.x, y: bananaCurrentPosition.y + monkey.size.height * 3)
        let bananaActionMove = SKAction.move(to: targetPoint, duration: 1.3)
        let bananaActionMove2 = SKAction.move(to: bananaCurrentPosition, duration: 1.3)
        let bananaRunAction = SKAction.sequence([bananaActionMove, bananaActionMove2])
        
        banana.run(bananaRunAction)
    }
}
