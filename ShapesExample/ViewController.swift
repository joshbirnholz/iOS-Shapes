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

	var squares: [Rectangle] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let rect = Rectangle(width: 100, height: 100)
		rect.center.x = 50
		rect.center.y = 100
		squares.append(rect)
	}
	
	func canvasExample() {
		let circle = Circle()
		circle.draggable = true
	}
	
	func createExample() {
		// 1. Create a circle
		let circle = Circle(radius: 3)
		circle.center.y += 19
		
		// 2. Create a rectangle
		let rectangle = Rectangle(width: 10, height: 5, cornerRadius: 0.75)
		rectangle.color = .purple
		rectangle.center.y += 12
		
		// 3. Create a line
		let line = Line(start: Point(x: -10, y: 9), end: Point(x: 10, y: 9), thickness: 0.5)
		line.center.y -= 3
		line.rotation = 170 * (Double.pi / 180)
		line.color = .yellow
		
		// 4. Create text
		let text = Text(string: "Hello world!", fontSize: 32.0, fontName: "Futura", color: .red)
		text.center.y -= 0
		
		// 5. Create an image
		let image = Image(name: "SwiftBird", tint: .green)
		image.size.width *= 0.5
		image.size.height *= 0.5
		image.center.y -= 7
		
		// 6. Create a pattern with rectangles
		let numRectangles = 4
		var xOffset = Double((numRectangles/2) * (-1))
		var yOffset = -19.0
		let saturationEnd = 0.911
		let saturationStart = 0.1
		let saturationStride = (saturationEnd - saturationStart)/Double(numRectangles)
		
		for i in 0...numRectangles {
			
			let rectangle = Rectangle(width: 10, height: 5, cornerRadius: 0.75)
			
			// set the color.
			let saturation = saturationEnd - (Double(numRectangles - i) * saturationStride)
			rectangle.color = Color(hue: 0.079, saturation: saturation, brightness: 0.934)
			
			// calculate the offset.
			rectangle.center = Point(x: xOffset, y: yOffset)
			xOffset += 1
			yOffset += 1
		}

	}

	func touchExample() {
		// create a circle and make it draggable.
		let circle = Circle(radius: 7.0)
		circle.color = Color.purple
		circle.draggable = true
		
		// when the circle is touched, make it darker and give it a shadow.
		circle.onTouchDown {
			circle.color = circle.color.darker()
			circle.dropShadow = Shadow()
		}
		
		// when the touch ends on the circle, change its color to a random color.
		circle.onTouchUp {
			circle.color = Color.random()
			circle.dropShadow = nil
		}
		
		// jump the circle to the point on the canvas that was touched.
		canvas.onTouchUp {
			circle.center = self.canvas.currentTouchPoints.first!
			circle.dropShadow = Shadow()
		}

	}
	
	func animateExample() {
		// create a line.
		let line = Line(start: Point(x: -10, y: 0), end: Point(x: 10, y: 0))
		line.color = .blue
		line.center.y += 6
		
		// create a Text object that, when tapped, will kick off the clockwise rotation animation.
		let rotateClockwiseText = Text(string: "Rotate Line Clockwise", fontSize: 21.0)
		rotateClockwiseText.color = .blue
		rotateClockwiseText.center.y -= 7
		
		// create a Text object that, when tapped, will kick off the counter-clockwise rotation animation.
		let rotateCounterClockwiseText = Text(string: "Rotate Line Counter Clockwise", fontSize: 21.0)
		rotateCounterClockwiseText.color = .blue
		rotateCounterClockwiseText.center.y -= 12
		
		let presentModalText = Text(string: "Present", fontSize: 21.0)
		presentModalText.color = .blue
		presentModalText.center.y -= 17
		
		// rotate the line clockwise with animation when the "Rotate Line Clockwise" text is tapped.
		rotateClockwiseText.onTouchUp {
			animate {
				line.rotation += Double.pi / 4
			}
		}
		
		// rotate the line counter clockwise with animation when the "Rotate Line Counter Clockwise" text is tapped.
		rotateCounterClockwiseText.onTouchUp {
			animate {
				line.rotation -= Double.pi / 4
			}
		}
		
		presentModalText.onTouchUp {
			class SecondVC: CanvasViewController {
				override func viewDidLoad() {
					super.viewDidLoad()
					
					let circle = Circle(radius: 7.0)
					circle.color = Color.purple
					circle.draggable = true
					
					// when the circle is touched, make it darker and give it a shadow.
					circle.onTouchDown {
						circle.color = circle.color.darker()
						circle.dropShadow = Shadow()
					}
					
					// when the touch ends on the circle, change its color to a random color.
					circle.onTouchUp {
						circle.color = Color.random()
						circle.dropShadow = nil
					}
					
					// jump the circle to the point on the canvas that was touched.
					canvas.onTouchUp {
						circle.center = self.canvas.currentTouchPoints.first!
						circle.dropShadow = Shadow()
					}
					
					let doneButon = Text(string: "Dismiss", fontSize: 21.0, color: .blue)
					doneButon.onTouchUp {
						self.dismiss(animated: true, completion: nil)
					}
				}
			}
			
			let vc = SecondVC()
			let nav = UINavigationController(rootViewController: vc)
			nav.modalPresentationStyle = .formSheet
			self.present(nav, animated: true, completion: nil)
		}

	}

}

