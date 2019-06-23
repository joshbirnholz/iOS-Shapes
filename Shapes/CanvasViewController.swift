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
	
	public typealias _ColorLiteralType = Color
	
}
