//
//  Simon.swift
//  ShapesExample
//
//  Created by Josh Birnholz on 6/12/19.
//  Copyright © 2019 Josh Birnholz. All rights reserved.
//

import Shapes

class SimonGame {
	enum SimonColor: CaseIterable {
		case blue, red, yellow, green
		
		var color: Color {
			switch self {
			case .blue:
				return .blue
			case .red:
				return .red
			case .green:
				return .green
			case .yellow:
				return .yellow
			}
		}
		
		var highlightedColor: Color {
			return color.lighter(percent: 0.3)
		}
		
		func rectTranslation(rectSize: Double) -> (x: Double, y: Double) {
			let dimension = rectSize/2
			switch self {
			case .red:
				return (-dimension, -dimension)
			case .blue:
				return (-dimension, dimension)
			case .green:
				return (dimension, dimension)
			case .yellow:
				return (dimension, -dimension)
			}
		}
		
		static func random() -> SimonColor {
		return allCases.randomElement()!
		}
	}
	
	var canvas: Canvas
	var clickedColors: [SimonColor]
	var colors: [SimonColor]
	var rectangles: [SimonColor: Rectangle]
	var isFlashingColors = false
	
	init(canvas: Canvas, size: Double) {
		self.canvas = canvas
		clickedColors = []
		colors = [.green, .red, .yellow, .blue]
		rectangles = [:]
		
		for color in SimonColor.allCases {
			let rect = Rectangle(canvas: canvas, width: size, height: size)
			let translation = color.rectTranslation(rectSize: size)
			rect.center.x += translation.x
			rect.center.y += translation.y
			rect.color = color.color
			rect.onTouchDown {
				rect.color = color.highlightedColor
			}
			rect.onTouchUp {
				rect.color = color.color
				self.didTapColor(color)
			}
			rect.onTouchCancelled {
				rect.color = color.color
			}
			
			rectangles[color] = rect
		}
	}
	
	func didTapColor(_ color: SimonColor) {
		print(color)
	}
	
	func flashColors() {
		isFlashingColors = true
		
		let flashDuration: Double = 0.7
		let inBetweenTime: Double = 0.35
		for (index, color) in colors.enumerated() {
			let rect = rectangles[color]!
			
			// TODO: Do animations
		}
			
	}
}
