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

public extension CanvasViewController {
	
	/// Shows a popup alert with a message and an OK button.
	///
	/// - Parameters:
	///   - message: The message to show in the alert.
	///   - completion: A block of code called for when the alert is dismissed.
	func showAlert(message: String, completion: (() -> Void)? = nil) {
		let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in completion?() })
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
	
	/// Shows a popup alert with a message. You can choose which options get shown.
	///
	/// - Parameters:
	///   - message: The message to show in the alert.
	///   - choices: The names of the buttons to show in the alert.
	///   - completion: A block of code called for when one of the options is chosen.
	func showChoice(message: String?, choices: [String], completion: @escaping (String) -> Void) {
		let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		for choice in choices {
			let action = UIAlertAction(title: choice, style: choice.lowercased() == "cancel" ? .cancel : .default, handler: { _ in completion(choice) })
			alert.addAction(action)
		}
		present(alert, animated: true, completion: nil)
	}
	
	/// Shows a popup alert which asks for text.
	///
	/// - Parameters:
	///   - message: The message to show in the alert.
	///   - placeholder: The text shown in the text box when it's empty.
	///   - text: The text already in the text box.
	///   - showCancelButton: If this is true, the alert will show a cancel button.
	///   - completion: A block of code called after text has been entered.
	func askForText(message: String?, placeholder: String? = nil, text: String? = nil, showCancelButton: Bool = false, completion: @escaping (String) -> Void) {
		let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		alert.addTextField {
			$0.placeholder = placeholder
			$0.text = text
		}
		let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in completion(alert.textFields?.first?.text ?? "") })
		alert.addAction(okAction)
		
		if showCancelButton {
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			alert.addAction(cancelAction)
		}
		
		present(alert, animated: true, completion: nil)
	}
	
}
