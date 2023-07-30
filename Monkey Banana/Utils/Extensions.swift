//
//  Extensions.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 24/07/2023.
//

import Foundation
import SpriteKit

extension CGPoint {
    func distance(to targetPoint: CGPoint) -> CGFloat {
        let xDist = self.x - targetPoint.x
        let yDist = self.y - targetPoint.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
}

extension SKPhysicsBody{
    func applyForce(targetPotint: CGPoint, magnitude: CGFloat){
        if let node = self.node{
            let dx = targetPotint.x - node.position.x
            let dy = targetPotint.y - node.position.y
            let distance = sqrt(dx * dx + dy * dy)
            let direction = CGVector(dx: dx / distance * magnitude, dy: dy / distance * magnitude)
            self.applyForce(direction)
        }
    }
}
