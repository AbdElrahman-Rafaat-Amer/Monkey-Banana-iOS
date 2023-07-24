//
//  Extensions.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 24/07/2023.
//

import Foundation

extension CGPoint {
    func distance(to targetPoint: CGPoint) -> CGFloat {
        let xDist = self.x - targetPoint.x
        let yDist = self.y - targetPoint.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
}
