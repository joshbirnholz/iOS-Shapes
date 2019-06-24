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
	
	var score = 0
	
	var highScore: Int {
		get {
			return UserDefaults.standard.integer(forKey: #function)
		}
		set {
			UserDefaults.standard.set(newValue, forKey: #function)
			updateHighScoreText()
		}
	}
	
	func updateHighScoreText() {
		highScoreText.string = "High Score: \(highScore)"
	}
	
	var text: Text
	var highScoreText: Text
	var canvas: Canvas
	var clickedColors: [SimonColor]
	var colors: [SimonColor]
	var rectangles: [SimonColor: Rectangle]
	var isFlashingColors = false
	
	init(canvas: Canvas, size: Double) {
		self.canvas = canvas
		clickedColors = []
		colors = []
		rectangles = [:]
		text = Text(canvas: canvas, string: "Tap to Start")
		text.center.y += size + 4
		text.color = .blue
		text.fontSize = 30
		
		highScoreText = Text(canvas: canvas, string: "")
		updateHighScoreText()
		highScoreText.center.y -= size + 4
		highScoreText.fontSize = 30
		
		text.onTouchUp(didTapText)
		
		for color in SimonColor.allCases {
			let rect = Rectangle(canvas: canvas, width: size, height: size)
			let translation = color.rectTranslation(rectSize: size)
			rect.center.x += translation.x
			rect.center.y += translation.y
			rect.color = color.color
			rect.onTouchDown {
				guard !self.isFlashingColors else { return }
				rect.color = color.highlightedColor
			}
			rect.onTouchUp {
				guard !self.isFlashingColors else { return }
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
		clickedColors.append(color)
		
		if colors.isEmpty || clickedColors.count == colors.count {
			clickedColors.removeAll()
			colors.append(.random())
			score += 1
			flashColors()
		} else if Array(colors.prefix(upTo: clickedColors.count)) != clickedColors {
			text.string = "Game over! Score: \(score). Tap here to play again."
			highScore = max(highScore, score)
			score = 0
			clickedColors.removeAll()
			colors.removeAll()
		}
		
	}
	
	func didTapText() {
		if colors.isEmpty {
			colors.append(.random())
			flashColors()
		}
	}
	
	func flashColors() {
		text.string = "Score: \(score)"
		isFlashingColors = true
		
		let flashDuration = 0.25
		let inBetweenTime: Double = 0.2
		
		var animations: [Animation] = []
		
		for color in colors {
			let rect = rectangles[color]!
			
			animations.append(Animation(duration: flashDuration, delay: inBetweenTime) {
				rect.color = color.highlightedColor
			})
			animations.append(Animation(duration: flashDuration, delay: inBetweenTime) {
				rect.color = color.color
			})
			
			// TODO: Do animations
		}
		
		self.isFlashingColors = true
		let animator = performAnimations(animations)
		animator.onFinish {
			self.isFlashingColors = false
		}
			
	}
}
