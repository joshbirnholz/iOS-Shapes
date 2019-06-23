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

public struct Animation {
	public var duration: Double
	public var delay: Double
	public var changes: () -> Void
	
	public init(duration: Double = 0.35, delay: Double = 0.0, _ changes: @escaping () -> Void) {
		self.duration = duration
		self.delay = delay
		self.changes = changes
	}
}

public func animate(_ animations: Animation..., loop: Bool = false) {
	animate(animations, loop: loop)
}

fileprivate func animate(_ animations: [Animation], index: Int = 0, loop: Bool = false) {
	var index = index
	if index >= animations.count {
		if loop {
			index = 0
		} else {
			return
		}
	}
	let current = animations[index]
	UIView.animate(withDuration: current.duration, delay: current.delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction, .curveLinear], animations: current.changes) { _ in
		animate(animations, index: index + 1, loop: loop)
	}
}
