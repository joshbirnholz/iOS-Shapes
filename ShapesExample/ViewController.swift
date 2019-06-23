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
		
		canvas.onTouchUp { (point) in
			let circle = self.Circle()
			circle.center = point
			circle.color = .random()
			
			let moveRight = Animation(duration: 1, delay: 0) {
				circle.center.x += 20
				circle.color = .random()
			}
			let moveLeft = Animation(duration: 1, delay: 0) {
				circle.center.x -= 20
				circle.color = .random()
			}
			let moveUp = Animation(duration: 1, delay: 0) {
				circle.center.y += 20
				circle.color = .random()
			}
			let moveDown = Animation(duration: 1, delay: 0) {
				circle.center.y -= 20
				circle.color = .random()
			}
			
			animate(moveRight, moveUp, moveLeft, moveDown, loop: true)
		}
		
	}

}

