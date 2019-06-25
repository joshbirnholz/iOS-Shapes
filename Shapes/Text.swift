//
//  Text.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

/// Text on the canvas.
///
///   - `color` The color to draw the text. The default value is black.
///   - `fontSize` The size in points to draw the text. The default value is 17.0.
///   - `fontName` The font name to draw the text with. The default value is the system font.
///
/// Additional properties that can affect the Text:
///
///   - `center`: The center point of the object. Changing this moves the object.
///   - `scale`: The amount to grow or shrink the object. A value of 1.0 is the natural (unscaled) size. A value of 0.5 would be 1/2 the orginal size, while a value of 2.0 would be twice the original size.
///   - `rotation`: The angle in radians to rotate this object. Changing this rotates the object counter clockwise about it's center. A value of 0.0 (the default) means no rotation. A value of π (3.14159…) will rotate the object 180°, and 2π will rotate a full 360°.
///   - `draggable`: Makes the object draggable with your finger on the canvas. The default value is false.
///   - `shadow`: The drop shadow for this object. The default is nil, which results in no shadow. To add a shadow, you can set this property, like this: `myObject.dropShadow = Shadow()`.
/// - localizationKey: Text
public class Text: AbstractDrawable {
    
    private var backingViewAsLabel: UILabel {
        return backingView as! UILabel
    }
    
    /// The string to draw the text.
    /// - localizationKey: Text.string
    public var string: String {
        get {
            return backingViewAsLabel.text ?? ""
        }
        set {
            backingViewAsLabel.text = newValue
            updateBackingViewSizeFromFont()
        }
    }
    
    /// The color to draw the text. The default value is black.
    /// - localizationKey: Text.color
    public var color: Color {
        get {
            return Color(uiColor: backingViewAsLabel.textColor)
        }
        set {
            backingViewAsLabel.textColor = newValue.uiColor
        }
    }
    
    /// The size, in points, to draw the text. The default value is 17.0.
    /// - localizationKey: Text.fontSize
    public var fontSize: Double {
        get {
            return Double(backingViewAsLabel.font.pointSize)
        }
        set {
            backingViewAsLabel.font = backingViewAsLabel.font.withSize(CGFloat(newValue))
            updateBackingViewSizeFromFont()
        }
    }
    
    /// The font name to draw the text with. The default value is the system font.
    /// - localizationKey: Text.fontName
    public var fontName: String {
        get {
            return backingViewAsLabel.font.fontName
        }
        set {
            if let font = UIFont.init(name: newValue, size: CGFloat(fontSize)) {
                backingViewAsLabel.font = font
                updateBackingViewSizeFromFont()
            }
        }
    }
	
	/// The technique to use for aligning the text.
	public var alignment: NSTextAlignment {
		get {
			return backingViewAsLabel.textAlignment
		}
		set {
			backingViewAsLabel.textAlignment = newValue
			updateBackingViewSizeFromFont()
		}
	}
	
	/// The maximum number of lines of text that should be shown. Set this value to 0 to use as many lines as needed.
	public var numberOfLines: Int {
		get {
			return backingViewAsLabel.numberOfLines
		}
		set {
			backingViewAsLabel.numberOfLines = newValue
			updateBackingViewSizeFromFont()
		}
	}
    
    /// Creates text centered on the canvas.
    ///
    /// - Parameter string: The string content to draw.
    /// - Parameter fontSize: The size in points to draw the text. The default value is 17.0.
    /// - Parameter fontName: The font name to draw the text with. The default value is the system font.
    /// - Parameter color: The color to draw the text. The default value is black.
    /// - localizationKey: Text(string:fontSize:fontName:color:)
	public init(canvas: Canvas, string: String, fontSize: Double = 17.0, fontName: String = "", color: Color = .black) {
        
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = string
        label.textColor = color.uiColor
        if let font = UIFont.init(name: fontName, size: CGFloat(fontSize)) {
            label.font = font
        } else {
            label.font = label.font.withSize(CGFloat(fontSize))
        }
        
        // we'll update our size below as a result of calling udpateBackingViewSizeFromFont().
		super.init(canvas: canvas, modelSize: Size(width: 0, height: 0), backingView: label)
        
        updateBackingViewSizeFromFont()
    }
    
    private func updateBackingViewSizeFromFont() {
        let preferredSize = backingViewAsLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        udpateBackingViewSizeFromScreenSize(screenSize: Size(preferredSize))
    }
}

extension Text: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return string
        }
    }
}

extension CanvasViewController {
	/// Creates text centered on the canvas.
	///
	/// - Parameter string: The string content to draw.
	/// - Parameter fontSize: The size in points to draw the text. The default value is 17.0.
	/// - Parameter fontName: The font name to draw the text with. The default value is the system font.
	/// - Parameter color: The color to draw the text. The default value is black.
	/// - localizationKey: Text(string:fontSize:fontName:color:)
	public func Text(string: String, fontSize: Double = 17.0, fontName: String = "", color: Color = .black) -> Text {
		return Shapes.Text(canvas: canvas, string: string, fontSize: fontSize, fontName: fontName, color: color)
	}
}
