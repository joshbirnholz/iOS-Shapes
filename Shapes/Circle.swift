//
//  Circle.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

private let DefaultRadius = 5.0

/// A circle on the canvas:
///
///   - `radius` The distance from the center of the circle to its outside edge. Must be 0.0 or greater.
///
/// Additional properties that can affect Circle:
///
///   - `color` The color to fill the shape with.
///   - `borderWidth` The border width of the shape. The default value is 2.0.
///   - `borderColor` The color to use for the border of the shape. The default value is the same as the fill color.
///   - `center` The center point of the object. Changing this moves the object.
///   - `scale` The amount to grow or shrink the object. A value of 1.0 is the natural (unscaled) size. A value of 0.5 would be 1/2 the original size, while a value of 2.0 would be twice the original size.
///   - `rotation` The angle in radians to rotate this object. Changing this rotates the object counter clockwise about its center. A value of 0.0 (the default) means no rotation. A value of π (3.14159…) will rotate the object 180°, and 2π will rotate a full 360°.
///   - `draggable` Makes the object draggable with your finger on the canvas. The default value is false.
///   - `shadow` The drop shadow for this object. The default is nil, which results in no shadow. To add a shadow, you can set this property, like this: `myObject.dropShadow = Shadow()`.
/// - localizationKey: Circle
public class Circle: Shape {
    
    /// The distance from the center of the circle to its outside edge.
    /// - localizationKey: Circle.radius
    public var radius = DefaultRadius {
        didSet {
            let diameter = radius * 2
            let modelSize = Size(width: diameter, height: diameter)
            updateBackingViewSizeFromModelSize(modelSize: modelSize)
        }
    }
    
    /// Creates a Circle centered on the canvas with a default `radius` of 5.0.
    /// - localizationKey: Circle()
	convenience public init(canvas: Canvas) {
		self.init(canvas: canvas, radius: DefaultRadius)
    }
    
    /// Creates a Circle centered on the canvas with the given `radius`.
    ///
    /// - Parameter radius: The distance from the center of the circle to its outside edge. Must be 0.0 or greater.
    /// - localizationKey: Circle(radius:)
	public init(canvas: Canvas, radius: Double) {
        self.radius = radius
        let diameter = radius * 2
		super.init(canvas: canvas, modelSize: Size(width: diameter, height: diameter), backingView: UIView())
    }
    
    internal override func sizeDidChange() {
        // we could use a shape mask and sublayers to draw the border, but using the corner radius works too.
        backingView.layer.cornerRadius = backingView.frame.width/2.0
    }
    
    public override func overlaps(_ other: AbstractDrawable) -> Bool {
        switch other {
        case let circle as Circle:
            return center.distance(toPoint: circle.center) < (radius + circle.radius)
        case let rect as Rectangle:
            let x = max(rect.center.x - rect.size.width/2, min(center.x, rect.center.x + rect.size.width/2))
            let y = max(rect.center.y - rect.size.height/2, min(center.y, rect.center.y + rect.size.height/2))
            return center.distance(toPoint: Point(x:x,y:y)) < radius
        case let image as Image:
            let center = canvas.convertPointFromScreen(screenPoint: image.backingView.center)
        case let text as Text:
            let center = canvas.convertPointFromScreen(screenPoint: text.backingView.center)
        default:
            return false
        }
        return false
    }
}

extension Circle: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return "Radius = \(radius)"
        }
    }
}

extension CanvasViewController {
	/// Creates a Circle centered on the canvas with a default `radius` of 5.0.
	/// - localizationKey: Circle()
	public func Circle() -> Circle {
		return Shapes.Circle(canvas: canvas)
	}
	
	/// Creates a Circle centered on the canvas with the given `radius`.
	///
	/// - Parameter radius: The distance from the center of the circle to its outside edge. Must be 0.0 or greater.
	/// - localizationKey: Circle(radius:)
	public func Circle(radius: Double) -> Circle {
		return Shapes.Circle(canvas: canvas, radius: radius)
	}
}
