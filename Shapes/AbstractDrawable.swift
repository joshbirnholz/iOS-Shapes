//
//  AbstractDrawable.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

/// An abstract object that all concrete drawable objects are derived from.
/// - localizationKey: AbstractDrawable
public class AbstractDrawable: Equatable {
	
	/// The canvas associated with the drawable.
	internal weak var canvas: Canvas!
	
	// MARK: Display API
	
	/// The drop shadow for this object. The default value is nil, which results in no shadow. To add a shadow, you can set this property, like this: `myObject.dropShadow = Shadow()`.
	/// - localizationKey: AbstractDrawable.dropShadow
	public var dropShadow: Shadow? = nil {
		didSet {
			if let dropShadow = dropShadow {
				let xOffset = CGFloat(canvas.convertMagnitudeToScreen(modelMagnitude: dropShadow.offset.x))
				let yOffset = CGFloat(canvas.convertMagnitudeToScreen(modelMagnitude: dropShadow.offset.y) * (-1))
				backingView.layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
				backingView.layer.shadowRadius = CGFloat(canvas.convertMagnitudeToScreen(modelMagnitude: dropShadow.blurRadius))
				backingView.layer.shadowOpacity = Float(dropShadow.opacity)
				backingView.layer.shadowColor = dropShadow.color.cgColor
			} else {
				backingView.layer.shadowOpacity = 0.0
			}
		}
	}
	
	/// How much to make the object grow or shrink. A value of 1.0 (the default) is the original (unscaled) size. A value of 0.5 is half the original size, and a value of 2.0 is twice the original size.
	/// - localizationKey: AbstractDrawable.scale
	public var scale: Double = 1.0 {
		didSet {
			let scaleFloat = CGFloat(scale)
			scaleTransform = CGAffineTransform(scaleX: scaleFloat, y: scaleFloat)
		}
	}
	
	/// The angle, in radians, to rotate this object. Changing this value rotates the object counter-clockwise around its center. A value of 0.0 (the default) means no rotation. A value of π (3.14159…) rotates the object 180°, and 2π rotates the object a full 360°.
	/// - localizationKey: AbstractDrawable.rotation
	public var rotation: Double = 0.0 {
		didSet {
			let rotationFloat = CGFloat(rotation)
			rotationTransform = CGAffineTransform(rotationAngle: rotationFloat)
		}
	}
	
	/// Makes the object draggable with your finger on the canvas. The default value is false.
	/// - localizationKey: AbstractDrawable.draggable
	public var draggable = false
	
	// MARK: Internal display
	
	private var scaleTransform: CGAffineTransform? = nil {
		didSet {
			updateDisplayForTransforms()
		}
	}
	
	private var rotationTransform: CGAffineTransform? = nil {
		didSet {
			updateDisplayForTransforms()
		}
	}
	
	internal func defaultRotationTransform() -> CGAffineTransform {
		return CGAffineTransform.identity
	}
	
	internal func updateDisplayForTransforms() {
		var transform = defaultRotationTransform()
		if let scaleTransform = scaleTransform {
			transform = transform.concatenating(scaleTransform)
		}
		if let rotationTransform = rotationTransform {
			transform = transform.concatenating(rotationTransform)
		}
		backingView.transform = transform
	}
	
	// MARK: Interaction API
	
	fileprivate var onTouchDownHandler: (() -> Void)?
	/// A code block that is called for when a touch down occurs on this object.
	/// - localizationKey: AbstractDrawable.onTouchDown(_:)
	public func onTouchDown(_ handler: @escaping () -> Void) {
		onTouchDownHandler = handler
	}
	
	fileprivate var onTouchUpHandler: (() -> Void)?
	/// A code block that is called for when a touch up occurs on this object.
	/// - localizationKey: AbstractDrawable.onTouchUp(_:)
	public func onTouchUp(_ handler: @escaping () -> Void) {
		onTouchUpHandler = handler
	}
	
	fileprivate var onTouchDragHandler: (() -> Void)?
	/// A code block that is called for when a drag occurs on this object.
	/// - localizationKey: AbstractDrawable.onTouchDrag(_:)
	public func onTouchDrag(_ handler: @escaping () -> Void) {
		onTouchDragHandler = handler
	}
	
	fileprivate var onTouchCancelledHandler: (() -> Void)?
	/// A code block that is called for when a touch has been canceled on this object. This may occur, for example, if the system presented a dialog while the user was interacting with this object.
	/// - localizationKey: AbstractDrawable.onTouchCancelled(_:)
	public func onTouchCancelled(_ handler: @escaping () -> Void) {
		onTouchCancelledHandler = handler
	}
    
    public func overlaps(_ other: AbstractDrawable) -> Bool {
        //        switch other {
        //        case let circle as Circle:
        //
        //        case let rect as Rectangle:
        //
        //        case let image as Image:
        //            let center = canvas.convertPointFromScreen(screenPoint: image.backingView.center)
        //        case let text as Text:
        //            let center = canvas.convertPointFromScreen(screenPoint: text.backingView.center)
        //        default:
        //            return false
        return false
    }
	
	// MARK: Internal
	
	internal let backingView: UIView
	
	internal var touchGestureRecognizer: TouchGestureRecognizer
	
	fileprivate var offsetFromTouchToCenter = Point(x: 0,y: 0)
	
	/// The center point of the object. Changing the center point moves the object.
	/// - localizationKey: AbstractDrawable.center
	public var center: Point {
		get {
			let frame = backingView.layer.presentation()?.frame ?? backingView.layer.frame
			return canvas.convertPointFromScreen(screenPoint: CGPoint(x: frame.midX, y: frame.midY))
		}
		set {
			let screenPoint = canvas.convertPointToScreen(modelPoint: newValue)
			backingView.center = screenPoint.cgPoint
		}
	}
	
	internal init(canvas: Canvas, modelSize: Size, backingView: UIView) {
		self.canvas = canvas
		self.backingView = backingView
		
		touchGestureRecognizer = TouchGestureRecognizer()
		touchGestureRecognizer.touchDelegate = self
		backingView.addGestureRecognizer(touchGestureRecognizer)
		
		updateBackingViewSizeFromModelSize(modelSize: modelSize)
		updateDisplayForTransforms()
		
		canvas.addDrawable(drawable: self)
	}
	
	internal func updateBackingViewSizeFromModelSize(modelSize: Size) {
		// adjust the size to be in points.
		var screenSize = modelSize
		screenSize.width *= canvas.numPointsPerUnit
		screenSize.height *= canvas.numPointsPerUnit
		
		// remove any transforms.
		backingView.transform = CGAffineTransform.identity
		
		udpateBackingViewSizeFromScreenSize(screenSize: screenSize)
		
		// add any transforms back.
		updateDisplayForTransforms()
	}
	
	internal func udpateBackingViewSizeFromScreenSize(screenSize: Size) {
		// remember the old center point.
		let oldCenter = backingView.center
		
		// set the default size on the view.
		backingView.frame.size = screenSize.cgSize
		
		// restore the center point.
		backingView.center = oldCenter
		
		// give subclasses a chance to react to the size change.
		self.sizeDidChange()
	}
	
	internal func sizeDidChange() {
		// nothing to do here -- hook for subclasses.
	}
	
	/// Adds this drawable to the canvas. If the drawable has already been added to the canvas, it does nothing.
	/// - localizationKey: AbstractDrawable.add()
	public func add() {
		canvas.addDrawable(drawable: self)
	}
	
	/// Removes this drawable from the canvas. If the drawable isn’t on the canvas, it does nothing.
	/// - localizationKey: AbstractDrawable.remove()
	public func remove() {
		canvas.removeDrawable(drawable: self)
	}
}

extension AbstractDrawable: TouchGestureRecognizerDelegate {
	
	func touchesBegan(touches: Set<UITouch>, with event: UIEvent) {
		
		guard let touch = touches.first else { return }
		
		if (draggable) {
			// Bring the shape to the front.
			if let superview = self.backingView.superview {
				superview.bringSubviewToFront(self.backingView)
			}
			
			animate {
				self.scale = 1.15
				self.rotation = self.rotation + (.pi / 4)
			}
		}
		
		// remember the offset from the touch to our center point.
		let screenLocation = touch.location(in: canvas)
		let canvasPoint = canvas.convertPointFromScreen(screenPoint: screenLocation)
		offsetFromTouchToCenter = Point(x: canvasPoint.x - center.x, y: canvasPoint.y - center.y)
		
		// notify the handler of the touch-down.
		onTouchDownHandler?()
	}
	
	func touchesMoved(touches: Set<UITouch>, with event: UIEvent) {
		
		guard let touch = touches.first else { return }
		
		let screenLocation = touch.location(in: canvas)
		let canvasPoint = canvas.convertPointFromScreen(screenPoint: screenLocation)
		
		if (draggable) {
			var adjustedPoint = canvasPoint
			adjustedPoint.x = canvasPoint.x - offsetFromTouchToCenter.x
			adjustedPoint.y = canvasPoint.y - offsetFromTouchToCenter.y
			self.center = adjustedPoint
		}
		
		// notify the handler of the dragged touch.
		onTouchDragHandler?()
	}
	
	func touchesEnded(touches: Set<UITouch>, with event: UIEvent) {
		cleanupAfterTouchIfNecessary()
		
		// notify the handler of the touch-up.
		onTouchUpHandler?()
	}
	
	func touchesCancelled(touches: Set<UITouch>, with event: UIEvent) {
		cleanupAfterTouchIfNecessary()
		
		// notify the handler of the cancelled touch.
		onTouchCancelledHandler?()
	}
	
	func wantsTouch(touch: UITouch) -> Bool {
		// we only want touches if we are draggable, or have a handler.
		return draggable || onTouchDownHandler != nil || onTouchDragHandler != nil || onTouchUpHandler != nil || onTouchCancelledHandler != nil
	}
	
	private func cleanupAfterTouchIfNecessary() {
		guard draggable else { return }
		
		// Reset the scale and rotation when touch is lifted
		animate {
			self.scale = 1.0
			self.rotation = self.rotation - (.pi / 4)
		}
	}
	
}

// MARK: Equatable protocol
public func ==(lhs: AbstractDrawable, rhs: AbstractDrawable) -> Bool {
	return lhs === rhs
}

/// https://stackoverflow.com/a/43684094
internal class AnimationLayerHitTestingView: UIView {
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		guard let pres = self.layer.presentation(), let superview = superview else {
			return super.hitTest(point, with: event)
		}
		let superviewPoint = convert(point, to: superview)
		let presentationPoint = superview.layer.convert(superviewPoint, to: pres)
		return super.hitTest(presentationPoint, with: event)
	}
}
