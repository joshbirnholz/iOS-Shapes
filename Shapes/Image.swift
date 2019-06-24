//
//  Image.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

private let MaxInitialWidth = 20.0
private let MaxInitialHeight = 20.0
private let DefaultImageContentMode = ImageContentMode.scaleToFitMaintainingAspectRatio

/// An image on the canvas.
///
///   - `size` The width and height of the image.
///   - `contentMode` Controls the way the image scales to fill its size.
///   - `tint` When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, while parts of the image with an alpha of less than 1.0 get treated as completely transparent.
///
/// Additional properties that can affect Image:
///
///   - `center` The center point of the object. Changing this moves the object.
///   - `scale` The amount to grow or shrink the object. A value of 1.0 is the natural (unscaled) size. A value of 0.5 would be 1/2 the original size, while a value of 2.0 would be twice the original size.
///   - `rotation` The angle in radians to rotate this object. Changing this rotates the object counter clockwise about its center. A value of 0.0 (the default) means no rotation. A value of π (3.14159…) will rotate the object 180°, and 2π will rotate a full 360°.
///   - `draggable` Makes the object draggable with your finger on the canvas. The default value is false.
///   - `shadow` The drop shadow for this object. The default is nil, which results in no shadow. To add a shadow, you can set this property, like this: `myObject.dropShadow = Shadow()`.
/// - localizationKey: Image
public class Image: AbstractDrawable {

    private var backingViewAsImageView: UIImageView {
        return backingView as! UIImageView
    }
    
    /// Controls the way the image scales to fill its size.
    /// - localizationKey: Image.contentMode
    public var contentMode: ImageContentMode {
        get {
            switch backingViewAsImageView.contentMode {
            case .scaleToFill:
                return .scaleAndStretchToFill
            case .scaleAspectFit:
                return .scaleToFitMaintainingAspectRatio
            default:
                // we shouldn't get here.
                return DefaultImageContentMode
            }
        }
        set {
            switch newValue {
            case .scaleAndStretchToFill:
                backingViewAsImageView.contentMode = .scaleToFill
            case .scaleToFitMaintainingAspectRatio:
                backingViewAsImageView.contentMode = .scaleAspectFit
            }
        }
    }
    
    /// The width and height to draw the image.
    /// - localizationKey: Image.size
    public var size = Size(width: 10.0, height: 10.0) {
        didSet {
            updateBackingViewSizeFromModelSize(modelSize: size)
        }
    }
    
    /// When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, and parts of the image with an alpha of less than 1.0 get treated as completely transparent.
    /// - localizationKey: Image.tint
    public var tint: Color? {
        get {
            return Color(uiColor:backingViewAsImageView.tintColor)
        }
        set {
            let renderingMode: UIImage.RenderingMode = newValue == nil ? .alwaysOriginal : .alwaysTemplate
            backingViewAsImageView.image = backingViewAsImageView.image?.withRenderingMode(renderingMode)
            backingViewAsImageView.tintColor = newValue?.uiColor
        }
    }
    
    /// Creates an image centered on the canvas.
    ///
    /// - Parameter name: The name of the image resource to use to create the image.
    /// - Parameter tint: When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, and parts of the image with an alpha of less than 1.0 get treated as completely transparent.
    /// - Parameter contentMode: Controls the way the image scales to fill its size.
    /// - localizationKey: Image(name:tint:contentMode:)
	public convenience init(canvas: Canvas, name: String, tint: Color? = nil, contentMode: ImageContentMode = .scaleToFitMaintainingAspectRatio) {
        
        let image = UIImage(named: name)
		self.init(canvas: canvas, image: image, tint: tint, contentMode: .scaleToFitMaintainingAspectRatio)
    }

    /// Creates an image centered on the canvas.
    ///
    /// - Parameter url: The URL that points to an image resource, to create an Image from.
    /// - Parameter tint: When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, and parts of the image with an alpha of less than 1.0 get treated as completely transparent.
    /// - Parameter contentMode: Controls the way the image scales to fill its size.
    /// - localizationKey: Image(url:tint:contentMode:)
	public convenience init(canvas: Canvas, url: String, tint: Color? = nil, contentMode: ImageContentMode = .scaleToFitMaintainingAspectRatio) {
        
        var image: UIImage?
        if let imageURL = URL(string: url) {
            if let imageData = try? Data(contentsOf: imageURL as URL) {
                image = UIImage(data: imageData as Data)
            }
        }
        
		self.init(canvas: canvas, image: image, tint: tint, contentMode: .scaleToFitMaintainingAspectRatio)
    }
    
	fileprivate init(canvas: Canvas, image: UIImage?, tint: Color? = nil, contentMode: ImageContentMode) {

        let imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        
        var modelSize = Size(width: 0, height: 0)
        if let image = image {
            var width = canvas.convertMagnitudeFromScreen(screenMagnitude: Double(image.size.width))
            var height = canvas.convertMagnitudeFromScreen(screenMagnitude: Double(image.size.height))
            
            let maxInitialWidth = MaxInitialWidth
            let maxInitialHeight = MaxInitialHeight
            
            let extraWidth = Double(width) - maxInitialWidth
            let extraHeight = Double(height) - maxInitialHeight
            
            if (extraWidth == 0 && extraHeight == 0) {
                // nothing to do.
            } else if (extraWidth > extraHeight) {
                // adjust the default size based on the width dimension, since it has more extra.
                let ratioOfHeightToWidth = height/width
                width = maxInitialWidth
                height = width * ratioOfHeightToWidth
            } else {
                // adjust the default size based on the height dimension, since it has more extra.
                let ratioOfWidthToHeight = width/height
                height = maxInitialHeight
                width = height * ratioOfWidthToHeight
            }
            
            modelSize = Size(width: width, height: height)
        }
        
		super.init(canvas: canvas, modelSize: modelSize, backingView: imageView)
        
        self.size = modelSize
        self.contentMode = contentMode
        self.tint = tint
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

/// Controls the way the image scales to fill its size.
/// - localizationKey: ImageContentMode
public enum ImageContentMode {
    /// Both scale and stretch the image when its natural size doesn't match the size it is being set to.
    /// - localizationKey: ImageContentMode.scaleAndStretchToFill
    case scaleAndStretchToFill
    /// Only scale and don't stretch the image when its natural size doesn't match the size it is being set to.
    /// - localizationKey: ImageContentMode.scaleToFitMaintainingAspectRatio
    case scaleToFitMaintainingAspectRatio
}

extension Image: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return "Width \(size.width), height = \(size.height)"
        }
    }
}

extension CanvasViewController {
	/// Creates an image centered on the canvas.
	///
	/// - Parameter name: The name of the image resource to use to create the image.
	/// - Parameter tint: When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, and parts of the image with an alpha of less than 1.0 get treated as completely transparent.
	/// - Parameter contentMode: Controls the way the image scales to fill its size.
	/// - localizationKey: Image(name:tint:contentMode:)
	public func Image(name: String, tint: Color? = nil, contentMode: ImageContentMode = .scaleToFitMaintainingAspectRatio) -> Image {
		return Shapes.Image(canvas: canvas, name: name, tint: tint, contentMode: contentMode)
	}
	
	/// Creates an image centered on the canvas.
	///
	/// - Parameter url: The URL that points to an image resource, to create an Image from.
	/// - Parameter tint: When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, and parts of the image with an alpha of less than 1.0 get treated as completely transparent.
	/// - Parameter contentMode: Controls the way the image scales to fill its size.
	/// - localizationKey: Image(url:tint:contentMode:)
	public func Image(url: String, tint: Color? = nil, contentMode: ImageContentMode = .scaleToFitMaintainingAspectRatio) -> Image {
		return Shapes.Image(canvas: canvas, url: url, tint: tint, contentMode: contentMode)
	}
	
	/// Creates an image centered on the canvas.
	///
	/// - Parameter image: The UIImage to create the Image with.
	/// - Parameter tint: When set to a non-nil value, parts of the image with an alpha value of 1.0 are filled with the tint color, and parts of the image with an alpha of less than 1.0 get treated as completely transparent.
	/// - Parameter contentMode: Controls the way the image scales to fill its size.
	public func Image(_ image: UIImage, tint: Color? = nil, contentMode: ImageContentMode = .scaleToFitMaintainingAspectRatio) -> Image {
		return Shapes.Image(canvas: canvas, image: image, tint: tint, contentMode: contentMode)
	}
}

public extension UIImage {
	func image(in canvas: Canvas, tint: Color? = nil, contentMode: ImageContentMode = .scaleToFitMaintainingAspectRatio) -> Image {
		return Shapes.Image(canvas: canvas, image: self, tint: tint, contentMode: contentMode)
	}
}
