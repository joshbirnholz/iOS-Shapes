//
//  CanvasViewController.swift
//  Shapes
//
//  Created by Josh Birnholz on 5/29/19.
//  Copyright © 2019 Josh Birnholz. All rights reserved.
//

import UIKit

open class CanvasViewController: UIViewController {

	public var canvas: Canvas {
		return view as! Canvas
	}

	/*
	/// The gravity object
	/// - localizationKey: Canvas.gravity
    var animator: UIDynamicAnimator? = nil;
	
    public let gravity = UIGravityBehavior()
    /// The collider object
    /// - localizationKey: Canvas.collider
    public let collider = UICollisionBehavior()

    override open func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view);
        gravity.gravityDirection = CGVector(dx: 0,dy: 0.8)
        animator?.addBehavior(gravity);
        
        // We're bounching off the walls
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
    }
    
    public func addGravity(to: AbstractDrawable) {
        gravity.addItem(to.backingView)
        collider.addItem(to.backingView)
    }
    
    public func addCollider(to: AbstractDrawable) {
        collider.addItem(to.backingView)
    }
	*/
	
	override open func loadView() {
		view = Canvas()
		view.backgroundColor = .white
	}
	
	fileprivate var setupComplete: Bool = false
	
	open override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if !setupComplete {
			setup()
			setupComplete = true
		}
	}
	
	/// Use this method to draw shapes, lines, and more on the canvas.
	open func setup() {
		
	}
	
	public func clear() {
		canvas.clear()
	}
	
	public typealias _ColorLiteralType = Color
	
}
