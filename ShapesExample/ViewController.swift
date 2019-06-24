//
//  ViewController.swift
//  ShapesExample
//
//  Created by Josh Birnholz on 5/29/19.
//  Copyright © 2019 Josh Birnholz. All rights reserved.
//

import UIKit
import Shapes

class ViewController: CanvasViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
        let rect = Rectangle(width: 20, height: 30)
        rect.color = .blue
		
		canvas.onTouchUp { (point) in
			let r2 = self.Circle(radius: 5)
            r2.center = point
            if (rect.overlaps(r2)) {
                r2.color = .red
            } else {
                r2.color = .green
            }
		}
		
	}

}

