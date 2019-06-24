//
//  Animation.swift
//  Shapes
//
//  Created by Josh Birnholz on 6/23/19.
//  Copyright © 2019 Josh Birnholz. All rights reserved.
//

import Foundation

// MARK: Animation API

/// Animates any changes that occur in the `changesToAnimate` block. For example, if you change the `center` of an object in the `changesToAnimate` block, the object animates to its location.
///
/// - Parameter duration: The length of the animation, in seconds. The default value is 0.35.
/// - Parameter delay: The amount of time, in seconds, before the animation starts. The default value is 0.0.
/// - Parameter changesToAnimate: The block of code to animate.
/// - localizationKey: animate(duration:delay:_:)
internal func animate(duration: Double = 0.35, delay: Double = 0.0, _ changesToAnimate: @escaping () -> Void) {
	UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.beginFromCurrentState, .allowUserInteraction], animations: changesToAnimate, completion:nil)
}

/// Represents an animation which perfrms the changes in the `changes` block. For example, if you change the `center` of an object in the `changes` block, the object will animates to its location.
///
/// Once you create an animation,
///
/// - `duration` The length of the animation, in seconds. The default value is 0.35.
/// - `delay` The amount of time, in seconds, before the animation starts.
public struct Animation {
	/// The length of the animation, in seconds. The default value is 0.35.
	public var duration: Double
	/// The amount of time, in seconds, before the animation starts.
	public var delay: Double
	/// The block of code to animate.
	public var changes: () -> Void
	
	/// Creates a new `Animation`.
	///
	/// The animation does not start until it is performed, like this:
	///
	///     let circle = Circle()
	///     let moveLeft = Animation {
	///         circle.center.x -= 20
	///     }
	///     performAnimations(moveLeft)
	///
	/// You can specify a custom duration or delay like this:
	///
	///     let moveRight = Animation(duration: 2.0, delay: 0.3) {
	///         circle.center.x += 20
	///     }
	///
	/// - Parameters:
	///   - duration: The length of the animation, in seconds. The default value is 0.35.
	///   - delay: The amount of time, in seconds, before the animation starts.
	///   - changes: The block of code to animate.
	public init(duration: Double = 0.35, delay: Double = 0.0, _ changes: @escaping () -> Void) {
		self.duration = duration
		self.delay = delay
		self.changes = changes
	}
}

public class Animator {
	
	public enum State: Int {
		/// The animations have not yet started.
		case inactive
		/// The animations are currently in progress.
		case active
		/// The animations are complete.
		case stopped
		/// The animations are paused and can be resumed by calling `start()`.
		case paused
	}
	
	/// The current state of the animation. The possible values are:
	/// - `inactive` The animations have not yet started.
	/// - `active` The animations are currently in progress.
	/// - `stopped` The animations are complete.
	/// - `paused` The animations are paused and can be resumed by calling `start()`.
	public fileprivate(set) var state: State = .inactive {
		didSet {
			if state == .stopped {
				onFinishHandler?()
			}
		}
	}
	
	/// Whether or not the animation repeats.
	public var repeats: Bool
	private var index: Int = 0
	
	/// The property animator assocated with the current (or most recent) animation step.
	fileprivate var propertyAnimator: UIViewPropertyAnimator?
	fileprivate let animations: [Animation]
	
	fileprivate var onFinishHandler: (() -> Void)?
	
	/// A code block that is called for when the animations have completed or been stopped.
	public func onFinish(_ handler: @escaping () -> Void) {
		onFinishHandler = handler
	}
	
	///
	public init(animations: [Animation], repeats: Bool) {
		self.animations = animations
		self.repeats = repeats
	}
	
	public convenience init(animations: Animation..., repeats: Bool) {
		self.init(animations: animations, repeats: repeats)
	}
	
	fileprivate func performNext() {
		if index >= animations.count {
			if repeats {
				index = 0
			} else {
				state = .stopped
				propertyAnimator = nil
				return
			}
		}
		
		let current = animations[index]
		propertyAnimator = .runningPropertyAnimator(withDuration: current.duration,
													delay: current.delay,
													options: [.beginFromCurrentState, .allowUserInteraction, .allowAnimatedContent],
													animations: current.changes) { _ in
														self.index += 1
														guard self.state == .active else {
															return
														}
														self.performNext()
		}
	}
	
	/// Starts the animations, or resumes paused animations. If the animations are stopped, this method restarts them.
	public func start() {
		switch state {
		case .inactive:
			state = .active
			performNext()
		case .stopped:
			propertyAnimator?.stopAnimation(true)
			index = 0
			state = .active
			performNext()
		case .paused:
			guard let animator = propertyAnimator, animator.state != .stopped else { return }
			animator.startAnimation()
			state = .active
		default:
			return
		}
	}
	
	/// Pauses the animations. Restart them with `.start()`.
	public func pause() {
		guard state != .stopped else { return }
		propertyAnimator?.pauseAnimation()
		state = .paused
	}
	
	/// Stops the animations.
	public func stop() {
		propertyAnimator?.stopAnimation(true)
//		if !withoutFinishing {
//			propertyAnimator?.finishAnimation(at: .current)
//		}
		propertyAnimator = nil
		state = .stopped
	}
}

/// Animates any changes that occur in the `changesToAnimate` block. For example, if you change the `center` of an object in the `changesToAnimate` block, the object animates to its location.
///
/// - Parameter duration: The length of the animation, in seconds. The default value is 0.35.
/// - Parameter delay: The amount of time, in seconds, before the animation starts. The default value is 0.0.
/// - Parameter changesToAnimate: The block of code to animate.
/// - Parameter repeats: If this is true, the animation will repeat. The default value is false.
@discardableResult public func performAnimations(duration: Double = 0.35, delay: Double = 0.0, _ changesToAnimate: @escaping () -> Void, repeats: Bool = false) -> Animator {
	let animator = Animator(animations: [Animation(duration: duration, delay: delay, changesToAnimate)], repeats: repeats)
	animator.start()
	return animator
}

/// Performs one or more animations.
///
/// Create an animation and then perform it as shown below.
///
///     let circle = Circle()
///     let moveLeft = Animation {
///         circle.center.x -= 20
///     }
///     performAnimations(moveLeft)
///
/// You can specify a custom duration or delay like this:
///
///     let moveRight = Animation(duration: 2.0, delay: 0.3) {
///         circle.center.x += 20
///     }
///
/// Perform more than one animation in order:
///
///     performAnimations(moveLeft, moveRight)
///
///	Make the animations loop by setting `repeats` to true.
///
///		performAnimations(moveLeft, moveRight, repeats: true)
///
/// - Parameters:
///   - animations: An array of animations to perform.
///   - repeats: Whether or not to loop the animations. The default value is false.
/// - Returns: An `Animator` that can be used to pause, stop, and restart the animation.
@discardableResult public func performAnimations(_ animations: Animation..., repeats: Bool = false) -> Animator {
	let animator = Animator(animations: animations, repeats: repeats)
	animator.start()
	return animator
}

/// Performs a series of animations.
///
/// Create an animation and then perform it as shown below.
///
///     let circle = Circle()
///
///     let moveLeft = Animation {
///         circle.center.x -= 20
///     }
///
///     let moveRight = Animation {
///         circle.center.x += 20
///     }
///
///		let animations = [moveLeft, moveRight]
///     performAnimations(animations)
///
/// - Parameters:
///   - animations: An array of animations to perform.
///   - repeats: Whether or not to loop the animations. The default value is false.
/// - Returns: An `Animator` that can be used to pause, stop, and restart the animation.
@discardableResult public func performAnimations(_ animations: [Animation], repeats: Bool = false) -> Animator {
	let animator = Animator(animations: animations, repeats: repeats)
	animator.start()
	return animator
}
