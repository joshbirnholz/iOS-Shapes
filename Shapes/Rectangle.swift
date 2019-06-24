//
//  Rectangle.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

private let DefaultWidth = 10.0
private let DefaultHeight = 10.0

/// A rectangle on the canvas.
///
///   - `size` The width and height of the rectangle.
///   - `cornerRadius` The amount to round the corners of the rectangle.
///
/// Additional properties that can affect Rectangle:
///
///   - `color` The color to fill the shape with.
///   - `borderWidth` The border width of the shape. The default value is 2.0.
///   - `borderColor` The color to use for the border of the shape. The default value is the same as the fill color.
///   - `center` The center point of the object. Changing this moves the object.
///   - `scale` The amount to grow or shrink the object. A value of 1.0 is the natural (unscaled) size. A value of 0.5 would be 1/2 the orginal size, while a value of 2.0 would be twice the original size.
///   - `rotation` The angle in radians to rotate this object. Changing this rotates the object counter clockwise about its center. A value of 0.0 (the default) means no rotation. A value of π (3.14159…) will rotate the object 180°, and 2π will rotate a full 360°.
///   - `draggable` Makes the object draggable with your finger on the canvas. The default value is false.
///   - `shadow` The drop shadow for this object. The default is nil, which results in no shadow. To add a shadow, you can set this property, like this: `myObject.dropShadow = Shadow()`.
/// - localizationKey: Rectangle
public class Rectangle: Shape {
    
    /// Creates a rectangle centered on the canvas with a default `width` (10.0), `height` (10.0) and `cornerRadius` (0.0).
    /// - localizationKey: Rectangle()
	public convenience init(canvas: Canvas) {
		self.init(canvas: canvas, width: DefaultWidth, height: DefaultHeight)
    }
    
    /// Creates a rectangle centered on the canvas.
    ///
    /// - Parameter width: The width of the rectangle.
    /// - Parameter height: The height of the rectangle.
    /// - Parameter cornerRadius: The amount to round the corners of the rectangle.
    /// - localizationKey: Rectangle(width:height:cornerRadius:)
	public init(canvas: Canvas, width: Double, height: Double, cornerRadius: Double = 0.0) {
        let size = Size(width: width, height: height)
		super.init(canvas: canvas, modelSize: size, backingView: UIView())
        
        self.size = size
        self.cornerRadius = cornerRadius
        updateCornerRadiusFromModel()
    }
    
    /// The width and height of the rectangle.
    /// - localizationKey: Rectangle.size
    public var size = Size(width: 10.0, height: 10.0) {
        didSet {
            updateBackingViewSizeFromModelSize(modelSize: size)
        }
    }

    /// The amount to round the corners of the rectangle.
    /// - localizationKey: Rectangle.cornerRadius
    public var cornerRadius = 0.0 {
        didSet {
            updateCornerRadiusFromModel()
        }
    }
    
    private func updateCornerRadiusFromModel() {
        let screenCornerRadius = canvas.convertMagnitudeToScreen(modelMagnitude: cornerRadius)
        backingView.layer.cornerRadius = CGFloat(screenCornerRadius)
    }
    
    public override func overlaps(_ other: AbstractDrawable) -> Bool {
        switch other {
            case let circle as Circle:
                return circle.overlaps(self)
            case let rect as Rectangle:
                if (abs(rect.center.x - center.x) > (size.width + rect.size.width)/2) { return false }
                if (abs(rect.center.y - center.y) > (size.height + rect.size.height)/2) { return false }
                return true;
            case let image as Image:
                if (abs(image.center.x - center.x) > (size.width + image.size.width)/2) { return false }
                if (abs(image.center.y - center.y) > (size.height + image.size.height)/2) { return false }
                return true;
            case let line as Line:
                return false
            default:
                return false
        }
        return false
    }

}

extension Rectangle: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return "Width = \(size.width), height = \(size.height)"
        }
    }
}

extension CanvasViewController {
	/// Creates a rectangle centered on the canvas with a default `width` (10.0), `height` (10.0) and `cornerRadius` (0.0).
	/// - localizationKey: Rectangle()
	public func Rectangle() -> Rectangle {
		return Shapes.Rectangle(canvas: canvas)
	}
	
	/// Creates a rectangle centered on the canvas.
	///
	/// - Parameter width: The width of the rectangle.
	/// - Parameter height: The height of the rectangle.
	/// - Parameter cornerRadius: The amount to round the corners of the rectangle.
	/// - localizationKey: Rectangle(width:height:cornerRadius:)
	public func Rectangle(width: Double, height: Double, cornerRadius: Double = 0.0) -> Rectangle {
		return Shapes.Rectangle(canvas: canvas, width: width, height: height, cornerRadius: cornerRadius)
	}
}
