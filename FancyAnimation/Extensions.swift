//
//  Extensions.swift
//  FancyAnimation
//
//  Created by Salim Braksa on 2/26/17.
//  Copyright © 2017 Salim Braksa. All rights reserved.
//

import UIKit

extension CGRect {
    
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width/2, y: center.y - size.height/2)
        self.init(origin: origin, size: size)
    }
    
    var topLeft: CGPoint {
        return origin
    }
    
    var topRight: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var bottomRight: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
    
    var allPoints: [CGPoint] {
        return [topLeft, topRight, bottomLeft, bottomRight]
    }
    
}

extension CGPoint {
    
    func distance(point: CGPoint) -> CGFloat {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
}
