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
		
		canvas.onTouchUp {
			let point = self.canvas.currentTouchPoints.first!
			
			let r2 = self.Circle(radius: 5)
            r2.center = point
            if (rect.overlaps(r2)) {
                r2.color = .red
            } else {
                r2.color = .green
            }
		}
	
//		canvas.onTouchUp {
//			let point = self.canvas.currentTouchPoints.first!
//			let circle = self.Circle(radius: 10)
//			circle.center = point
//			circle.color = .random()
//
//			let moveRight = Animation(duration: 1) {
//				circle.center.x += 20
//				circle.color = .random()
//			}
//			let moveLeft = Animation(duration: 1) {
//				circle.center.x -= 20
//				circle.color = .random()
//			}
//			let moveUp = Animation(duration: 1) {
//				circle.center.y += 20
//				circle.color = .random()
//			}
//			let moveDown = Animation(duration: 1) {
//				circle.center.y -= 20
//				circle.color = .random()
//			}
//
//			let animator = performAnimations(moveRight, moveUp, moveLeft, moveDown, repeats: false)
//
//			circle.onTouchUp {
//				if animator.state == .active {
//					animator.stop()
//				} else {
//					animator.start()
//				}
//			}
//
//			animator.onFinish {
////				animator.start()
//			}
//
//		}
	
	}

}

