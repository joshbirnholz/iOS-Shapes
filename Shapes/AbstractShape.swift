//
//  AbstractShape.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

/// An abstract class that all concrete shapes derive from.
/// - localizationKey: Shape
public class Shape: AbstractDrawable {

    /// The color to fill the shape with.
    /// - localizationKey: Shape.color
    public var color = Color.blue {
        didSet {
            backingView.backgroundColor = color.uiColor
        }
    }
    
    /// The border width of the shape. The default value is 2.0.
    /// - localizationKey: Shape.borderWidth
    public var borderWidth = 2.0 {
        didSet {
            backingView.layer.borderWidth = CGFloat(borderWidth)
        }
    }
    
    /// The color to use for the border of the shape. The default value is the same as the fill color.
    /// - localizationKey: Shape.borderColor
    public var borderColor = Color.clear {
        didSet {
            backingView.layer.borderColor = borderColor.cgColor
        }
    }
    
	override internal init(canvas: Canvas, modelSize: Size, backingView: UIView) {
        
		super.init(canvas: canvas, modelSize: modelSize, backingView: backingView)
        
        backingView.layer.borderWidth = CGFloat(borderWidth)
        backingView.layer.borderColor = borderColor.cgColor
        backingView.backgroundColor = color.uiColor
    }
    
}

