//
//  Point.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

/// A point on the canvas that can be used (for example) to specify the center point of an object.
///
/// - localizationKey: Point
public struct Point {
    
    /// The horizontal (left/right) component of this point.
    /// - localizationKey: Point.x
    public var x = 0.0
    
    /// The vertical (up/down) component of this point.
    /// - localizationKey: Point.y
    public var y = 0.0
    
    internal var cgPoint: CGPoint {
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
    
    /// Creates a Point with the given x and y.
    ///
    /// - Parameter x: The horizontal (left/right) component of this point.
    /// - Parameter y: The vertical (up/down) component of this point.
    /// - localizationKey: Point(x:y:)
    public init(x:Double, y: Double) {
        self.x = x
        self.y = y
    }
        
    internal init(_ cgPoint: CGPoint) {
        x = Double(cgPoint.x)
        y = Double(cgPoint.y)
    }
	
	
    public func distance(to point: Point) -> Double {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

extension Point: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return "x = \(x), y = \(y)"
        }
    }
}

public extension CGPoint {
	var point: Point {
		return Point(self)
	}
}
