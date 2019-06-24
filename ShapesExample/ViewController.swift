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
        let wall1 = Rectangle(width: 20, height: 2)
        wall1.center = Point(x: 20, y: -20)
        addCollider(to: wall1)
//        addGravity(to: rect)
        canvas.onTouchUp {
            let rect = self.Rectangle(width: 10, height: 5)
            let point = self.canvas.currentTouchPoints.first!
            rect.center = point
            rect.color = .random()
            self.addGravity(to: rect)
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

