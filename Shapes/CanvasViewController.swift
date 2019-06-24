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
	
	public typealias _ColorLiteralType = Color
	
}
