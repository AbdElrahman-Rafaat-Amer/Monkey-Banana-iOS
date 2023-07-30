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
    private var monkeySpeed: CGFloat = 1
    
    override func didMove(to view: SKView) {
        
        setupPhysics()
        
        monkey.setScale(0.4)
        addBackground()
        addBottomGround()
        addBanana()
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 4.8),
                SKAction.run(addMonkey)
            ])
        ))
    }
    
    private func setupPhysics(){
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        let leftBottomPoint = CGPoint(x: 0, y: 0)
        let leftTopPoint = CGPoint(x: 0, y: size.height)
        
        self.physicsBody = SKPhysicsBody.init(edgeFrom: leftBottomPoint, to: leftTopPoint)
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.screenEdge
        self.physicsBody?.contactTestBitMask = PhysicsCategory.monkey
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
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
        
        banana.physicsBody = SKPhysicsBody(rectangleOf: banana.size)
        banana.physicsBody?.isDynamic = true
        banana.physicsBody?.categoryBitMask = PhysicsCategory.banana
        banana.physicsBody?.contactTestBitMask = PhysicsCategory.monkey
        banana.physicsBody?.collisionBitMask = PhysicsCategory.none
        banana.physicsBody?.mass = 15
        banana.physicsBody?.friction = 10
        banana.physicsBody?.linearDamping = 10
        
        addChild(banana)
    }
    
    private func addMonkey(){
        let monkey = SKSpriteNode(imageNamed: "ic_monkey")
        monkey.setScale(0.4)
        let monkeyX = size.width
        let monkeyY = monkey.size.height/2 + ground.size.height/2
        let startPoint = CGPoint(x: monkeyX, y: monkeyY)
        monkey.position = startPoint
        
        monkey.physicsBody = SKPhysicsBody(rectangleOf: monkey.size)
        monkey.physicsBody?.isDynamic = true
        monkey.physicsBody?.categoryBitMask = PhysicsCategory.monkey
        monkey.physicsBody?.contactTestBitMask = PhysicsCategory.banana
        monkey.physicsBody?.collisionBitMask = PhysicsCategory.none
        monkey.physicsBody?.usesPreciseCollisionDetection = true
        monkey.physicsBody?.mass = 0.00015
        monkey.physicsBody?.friction = 0
        monkey.physicsBody?.linearDamping = 0
        
        addChild(monkey)
        
        monkey.physicsBody?.applyForce(targetPotint: banana.position, magnitude: monkeySpeed)
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

extension GameScene : SKPhysicsContactDelegate {
    
    func didEnd(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.monkey != 0) && (secondBody.categoryBitMask & PhysicsCategory.banana != 0){
            //banana collide with monkey
            //game over
            print("Abdo gameOver")
        }else if (firstBody.categoryBitMask & PhysicsCategory.monkey != 0) && (secondBody.categoryBitMask & PhysicsCategory.screenEdge != 0){
            if let monkey = firstBody.node {
                //monkey reach the screen edge and will be deleted
                print("Abdo monkey will be removed")
                monkey.removeFromParent()
            }
        }
    }
}
