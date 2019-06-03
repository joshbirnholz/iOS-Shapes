//
//  Color.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

/// A color that can be used to change how objects on your canvas draw.
///
/// Choose specific colors, such as orange, or create your own colors by specifying the red, green, blue, and alpha (transparency) values.
///
/// Methods for modifying colors include:
///
/// - `lighter(percent: Double)`: Lighten a color
/// - `darker(percent: Double)`: Darken a color
/// - `withAlpha(percent: Double)`: Set the alpha (transparency) of a color
/// - `random()`: Pick a random color
/// - localizationKey: Color
public class Color: _ExpressibleByColorLiteral, Equatable {
    
    internal let uiColor: UIColor
    
    internal var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    public static let clear: Color = #colorLiteral(red: 1, green: 0.9999743700027466, blue: 0.9999912977218628, alpha: 0)
	
	public static let pink: Color = #colorLiteral(red: 1.0, green: 0.7529411764705882, blue: 0.796078431372549, alpha: 1.0)
	public static let lightPink: Color = #colorLiteral(red: 1.0, green: 0.7137254901960784, blue: 0.7568627450980392, alpha: 1.0)
	public static let hotPink: Color = #colorLiteral(red: 1.0, green: 0.4117647058823529, blue: 0.7058823529411765, alpha: 1.0)
	public static let deepPink: Color = #colorLiteral(red: 1.0, green: 0.0784313725490196, blue: 0.5764705882352941, alpha: 1.0)
	public static let paleVioletBlue: Color = #colorLiteral(red: 0.8588235294117647, green: 0.4392156862745098, blue: 0.5764705882352941, alpha: 1.0)
	public static let mediumVioletRed: Color = #colorLiteral(red: 0.7803921568627451, green: 0.08235294117647059, blue: 0.5215686274509804, alpha: 1.0)
	public static let lightSalmon: Color = #colorLiteral(red: 1.0, green: 0.6274509803921569, blue: 0.47843137254901963, alpha: 1.0)
	public static let salmon: Color = #colorLiteral(red: 0.9803921568627451, green: 0.5019607843137255, blue: 0.4470588235294118, alpha: 1.0)
	public static let darkSalmon: Color = #colorLiteral(red: 0.9137254901960784, green: 0.5882352941176471, blue: 0.47843137254901963, alpha: 1.0)
	public static let lightCoral: Color = #colorLiteral(red: 0.9411764705882353, green: 0.5019607843137255, blue: 0.5019607843137255, alpha: 1.0)
	public static let indianRed: Color = #colorLiteral(red: 0.803921568627451, green: 0.3607843137254902, blue: 0.3607843137254902, alpha: 1.0)
	public static let crimson: Color = #colorLiteral(red: 0.8627450980392157, green: 0.0784313725490196, blue: 0.23529411764705882, alpha: 1.0)
	public static let fireBrick: Color = #colorLiteral(red: 0.6980392156862745, green: 0.13333333333333333, blue: 0.13333333333333333, alpha: 1.0)
	public static let red: Color = #colorLiteral(red: 0.7294117647, green: 0.07058823529, blue: 0.03921568627, alpha: 1)
	public static let darkRed: Color = #colorLiteral(red: 0.5450980392156862, green: 0.0, blue: 0.0, alpha: 1.0)
	public static let brightRed: Color = #colorLiteral(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
	public static let orangeRed: Color = #colorLiteral(red: 1.0, green: 0.27058823529411763, blue: 0.0, alpha: 1.0)
	public static let tomato: Color = #colorLiteral(red: 1.0, green: 0.38823529411764707, blue: 0.2784313725490196, alpha: 1.0)
	public static let coral: Color = #colorLiteral(red: 1.0, green: 0.4980392156862745, blue: 0.3137254901960784, alpha: 1.0)
	public static let darkOrange: Color = #colorLiteral(red: 1.0, green: 0.5490196078431373, blue: 0.0, alpha: 1.0)
	public static let lightOrange: Color = #colorLiteral(red: 1.0, green: 0.6470588235294118, blue: 0.0, alpha: 1.0)
	public static let orange:Color = #colorLiteral(red: 0.8941176470588236, green: 0.4705882352941176, blue: 0.08627450980392157, alpha: 1)
	public static let brightYellow: Color = #colorLiteral(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
	public static let yellow:Color = #colorLiteral(red: 0.9490196078431372, green: 0.8, blue: 0.1215686274509804, alpha: 1)
	public static let lightYellow: Color = #colorLiteral(red: 1.0, green: 1.0, blue: 0.8784313725490196, alpha: 1.0)
	public static let lemonChiffon: Color = #colorLiteral(red: 1.0, green: 0.9803921568627451, blue: 0.803921568627451, alpha: 1.0)
	public static let lightGoldenrod: Color = #colorLiteral(red: 0.9803921568627451, green: 0.9803921568627451, blue: 0.8235294117647058, alpha: 1.0)
	public static let papayaWhip: Color = #colorLiteral(red: 1.0, green: 0.9372549019607843, blue: 0.8352941176470589, alpha: 1.0)
	public static let moccasin: Color = #colorLiteral(red: 1.0, green: 0.8941176470588236, blue: 0.7098039215686275, alpha: 1.0)
	public static let peachPuff: Color = #colorLiteral(red: 1.0, green: 0.8549019607843137, blue: 0.7254901960784313, alpha: 1.0)
	public static let paleGoldenrod: Color = #colorLiteral(red: 0.9333333333333333, green: 0.9098039215686274, blue: 0.6666666666666666, alpha: 1.0)
	public static let khaki: Color = #colorLiteral(red: 0.9411764705882353, green: 0.9019607843137255, blue: 0.5490196078431373, alpha: 1.0)
	public static let darkKhaki: Color = #colorLiteral(red: 0.7411764705882353, green: 0.7176470588235294, blue: 0.4196078431372549, alpha: 1.0)
	public static let gold: Color = #colorLiteral(red: 1.0, green: 0.8431372549019608, blue: 0.0, alpha: 1.0)
	public static let cornSilk: Color = #colorLiteral(red: 1.0, green: 0.9725490196078431, blue: 0.8627450980392157, alpha: 1.0)
	public static let blanchedAlmond: Color = #colorLiteral(red: 1.0, green: 0.9215686274509803, blue: 0.803921568627451, alpha: 1.0)
	public static let bisque: Color = #colorLiteral(red: 1.0, green: 0.8941176470588236, blue: 0.7686274509803922, alpha: 1.0)
	public static let navajoWhite: Color = #colorLiteral(red: 1.0, green: 0.8705882352941177, blue: 0.6784313725490196, alpha: 1.0)
	public static let wheat: Color = #colorLiteral(red: 0.9607843137254902, green: 0.8705882352941177, blue: 0.7019607843137254, alpha: 1.0)
	public static let burlyWood: Color = #colorLiteral(red: 0.8705882352941177, green: 0.7215686274509804, blue: 0.5294117647058824, alpha: 1.0)
	public static let tan: Color = #colorLiteral(red: 0.8235294117647058, green: 0.7058823529411765, blue: 0.5490196078431373, alpha: 1.0)
	public static let rosyBrown: Color = #colorLiteral(red: 0.7372549019607844, green: 0.5607843137254902, blue: 0.5607843137254902, alpha: 1.0)
	public static let sandyBrown: Color = #colorLiteral(red: 0.9568627450980393, green: 0.6431372549019608, blue: 0.3764705882352941, alpha: 1.0)
	public static let goldenrod: Color = #colorLiteral(red: 0.8549019607843137, green: 0.6470588235294118, blue: 0.12549019607843137, alpha: 1.0)
	public static let darkGoldenrod: Color = #colorLiteral(red: 0.7215686274509804, green: 0.5254901960784314, blue: 0.043137254901960784, alpha: 1.0)
	public static let peru: Color = #colorLiteral(red: 0.803921568627451, green: 0.5215686274509804, blue: 0.24705882352941178, alpha: 1.0)
	public static let chocolate: Color = #colorLiteral(red: 0.8235294117647058, green: 0.4117647058823529, blue: 0.11764705882352941, alpha: 1.0)
	public static let saddleBrown: Color = #colorLiteral(red: 0.5450980392156862, green: 0.27058823529411763, blue: 0.07450980392156863, alpha: 1.0)
	public static let sienna: Color = #colorLiteral(red: 0.6274509803921569, green: 0.3215686274509804, blue: 0.17647058823529413, alpha: 1.0)
	public static let crown: Color = #colorLiteral(red: 0.6470588235294118, green: 0.16470588235294117, blue: 0.16470588235294117, alpha: 1.0)
	public static let maroon: Color = #colorLiteral(red: 0.5019607843137255, green: 0.0, blue: 0.0, alpha: 1.0)
	public static let darkOliveGreen: Color = #colorLiteral(red: 0.3333333333333333, green: 0.4196078431372549, blue: 0.1843137254901961, alpha: 1.0)
	public static let olive: Color = #colorLiteral(red: 0.5019607843137255, green: 0.5019607843137255, blue: 0.0, alpha: 1.0)
	public static let oliveDrab: Color = #colorLiteral(red: 0.4196078431372549, green: 0.5568627450980392, blue: 0.13725490196078433, alpha: 1.0)
	public static let yellowGreen: Color = #colorLiteral(red: 0.6039215686274509, green: 0.803921568627451, blue: 0.19607843137254902, alpha: 1.0)
	public static let limeGreen: Color = #colorLiteral(red: 0.19607843137254902, green: 0.803921568627451, blue: 0.19607843137254902, alpha: 1.0)
	public static let lime: Color = #colorLiteral(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
	public static let green:Color = #colorLiteral(red: 0.3725490196078431, green: 0.7176470588235294, blue: 0.196078431372549, alpha: 1)
	public static let lawnGreen: Color = #colorLiteral(red: 0.48627450980392156, green: 0.9882352941176471, blue: 0.0, alpha: 1.0)
	public static let chartreuse: Color = #colorLiteral(red: 0.4980392156862745, green: 1.0, blue: 0.0, alpha: 1.0)
	public static let greenYellow: Color = #colorLiteral(red: 0.6784313725490196, green: 1.0, blue: 0.1843137254901961, alpha: 1.0)
	public static let springGreen: Color = #colorLiteral(red: 0.0, green: 1.0, blue: 0.4980392156862745, alpha: 1.0)
	public static let mediumSpringGreen: Color = #colorLiteral(red: 0.0, green: 0.9803921568627451, blue: 0.6039215686274509, alpha: 1.0)
	public static let lightGreen: Color = #colorLiteral(red: 0.5647058823529412, green: 0.9333333333333333, blue: 0.5647058823529412, alpha: 1.0)
	public static let paleGreen: Color = #colorLiteral(red: 0.596078431372549, green: 0.984313725490196, blue: 0.596078431372549, alpha: 1.0)
	public static let darkSeaGreen: Color = #colorLiteral(red: 0.5607843137254902, green: 0.7372549019607844, blue: 0.5607843137254902, alpha: 1.0)
	public static let mediumAquamarine: Color = #colorLiteral(red: 0.4, green: 0.803921568627451, blue: 0.6666666666666666, alpha: 1.0)
	public static let mediumSeaGreen: Color = #colorLiteral(red: 0.23529411764705882, green: 0.7019607843137254, blue: 0.44313725490196076, alpha: 1.0)
	public static let seaGreen: Color = #colorLiteral(red: 0.1803921568627451, green: 0.5450980392156862, blue: 0.3411764705882353, alpha: 1.0)
	public static let forestGreen: Color = #colorLiteral(red: 0.13333333333333333, green: 0.5450980392156862, blue: 0.13333333333333333, alpha: 1.0)
	public static let deepGreen: Color = #colorLiteral(red: 0.0, green: 0.5019607843137255, blue: 0.0, alpha: 1.0)
	public static let darkGreen: Color = #colorLiteral(red: 0.0, green: 0.39215686274509803, blue: 0.0, alpha: 1.0)
	public static let aqua: Color = #colorLiteral(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
	public static let cyan: Color = #colorLiteral(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
	public static let lightCyan: Color = #colorLiteral(red: 0.8784313725490196, green: 1.0, blue: 1.0, alpha: 1.0)
	public static let paleTurquoise: Color = #colorLiteral(red: 0.6862745098039216, green: 0.9333333333333333, blue: 0.9333333333333333, alpha: 1.0)
	public static let aquamarine: Color = #colorLiteral(red: 0.4980392156862745, green: 1.0, blue: 0.8313725490196079, alpha: 1.0)
	public static let turquoise: Color = #colorLiteral(red: 0.25098039215686274, green: 0.8784313725490196, blue: 0.8156862745098039, alpha: 1.0)
	public static let mediumTurquoise: Color = #colorLiteral(red: 0.2823529411764706, green: 0.8196078431372549, blue: 0.8, alpha: 1.0)
	public static let darkTurquoise: Color = #colorLiteral(red: 0.0, green: 0.807843137254902, blue: 0.8196078431372549, alpha: 1.0)
	public static let lightSeaGreen: Color = #colorLiteral(red: 0.12549019607843137, green: 0.6980392156862745, blue: 0.6666666666666666, alpha: 1.0)
	public static let cadetBlue: Color = #colorLiteral(red: 0.37254901960784315, green: 0.6196078431372549, blue: 0.6274509803921569, alpha: 1.0)
	public static let darkCyan: Color = #colorLiteral(red: 0.0, green: 0.5450980392156862, blue: 0.5450980392156862, alpha: 1.0)
	public static let teal: Color = #colorLiteral(red: 0.0, green: 0.5019607843137255, blue: 0.5019607843137255, alpha: 1.0)
	public static let lightSteelBlue: Color = #colorLiteral(red: 0.6901960784313725, green: 0.7686274509803922, blue: 0.8705882352941177, alpha: 1.0)
	public static let powderBlue: Color = #colorLiteral(red: 0.6901960784313725, green: 0.8784313725490196, blue: 0.9019607843137255, alpha: 1.0)
	public static let lightBlue: Color = #colorLiteral(red: 0.6784313725490196, green: 0.8470588235294118, blue: 0.9019607843137255, alpha: 1.0)
	public static let skyBlue: Color = #colorLiteral(red: 0.5294117647058824, green: 0.807843137254902, blue: 0.9215686274509803, alpha: 1.0)
	public static let lightSkyBlue: Color = #colorLiteral(red: 0.5294117647058824, green: 0.807843137254902, blue: 0.9803921568627451, alpha: 1.0)
	public static let deepSkyBlue: Color = #colorLiteral(red: 0.0, green: 0.7490196078431373, blue: 1.0, alpha: 1.0)
	public static let dodgerBlue: Color = #colorLiteral(red: 0.11764705882352941, green: 0.5647058823529412, blue: 1.0, alpha: 1.0)
	public static let blue:Color = #colorLiteral(red: 0.2627450980392157, green: 0.5803921568627451, blue: 0.9686274509803922, alpha: 1)
	public static let cornflowerBlue: Color = #colorLiteral(red: 0.39215686274509803, green: 0.5843137254901961, blue: 0.9294117647058824, alpha: 1.0)
	public static let steelBlue: Color = #colorLiteral(red: 0.27450980392156865, green: 0.5098039215686274, blue: 0.7058823529411765, alpha: 1.0)
	public static let royalBlue: Color = #colorLiteral(red: 0.2549019607843137, green: 0.4117647058823529, blue: 0.8823529411764706, alpha: 1.0)
	public static let deepBlue: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
	public static let mediumBlue: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.803921568627451, alpha: 1.0)
	public static let darkBlue: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.5450980392156862, alpha: 1.0)
	public static let navy: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.5019607843137255, alpha: 1.0)
	public static let midnightBlue: Color = #colorLiteral(red: 0.09803921568627451, green: 0.09803921568627451, blue: 0.4392156862745098, alpha: 1.0)
	public static let lavendar: Color = #colorLiteral(red: 0.9019607843137255, green: 0.9019607843137255, blue: 0.9803921568627451, alpha: 1.0)
	public static let thistle: Color = #colorLiteral(red: 0.8470588235294118, green: 0.7490196078431373, blue: 0.8470588235294118, alpha: 1.0)
	public static let plum: Color = #colorLiteral(red: 0.8666666666666667, green: 0.6274509803921569, blue: 0.8666666666666667, alpha: 1.0)
	public static let violet: Color = #colorLiteral(red: 0.9333333333333333, green: 0.5098039215686274, blue: 0.9333333333333333, alpha: 1.0)
	public static let orchid: Color = #colorLiteral(red: 0.8549019607843137, green: 0.4392156862745098, blue: 0.8392156862745098, alpha: 1.0)
	public static let fuchsia: Color = #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
	public static let magenta: Color = #colorLiteral(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
	public static let mediumOrchid: Color = #colorLiteral(red: 0.7294117647058823, green: 0.3333333333333333, blue: 0.8274509803921568, alpha: 1.0)
	public static let mediumPurple: Color = #colorLiteral(red: 0.5764705882352941, green: 0.4392156862745098, blue: 0.8588235294117647, alpha: 1.0)
	public static let blueViolet: Color = #colorLiteral(red: 0.5411764705882353, green: 0.16862745098039217, blue: 0.8862745098039215, alpha: 1.0)
	public static let darkViolet: Color = #colorLiteral(red: 0.5803921568627451, green: 0.0, blue: 0.8274509803921568, alpha: 1.0)
	public static let darkOrchid: Color = #colorLiteral(red: 0.6, green: 0.19607843137254902, blue: 0.8, alpha: 1.0)
	public static let mediumMagenta: Color = #colorLiteral(red: 0.5450980392156862, green: 0.0, blue: 0.5450980392156862, alpha: 1.0)
	public static let darkMagenta: Color = #colorLiteral(red: 0.5019607843137255, green: 0.0, blue: 0.5019607843137255, alpha: 1.0)
	public static let purple:Color = #colorLiteral(red: 0.3843137254901961, green: 0.1607843137254902, blue: 0.5372549019607843, alpha: 1)
	public static let indigo: Color = #colorLiteral(red: 0.29411764705882354, green: 0.0, blue: 0.5098039215686274, alpha: 1.0)
	public static let darkSlateBlue: Color = #colorLiteral(red: 0.2823529411764706, green: 0.23921568627450981, blue: 0.5450980392156862, alpha: 1.0)
	public static let slateBlue: Color = #colorLiteral(red: 0.41568627450980394, green: 0.35294117647058826, blue: 0.803921568627451, alpha: 1.0)
	public static let mediumSlateBlue: Color = #colorLiteral(red: 0.4823529411764706, green: 0.40784313725490196, blue: 0.9333333333333333, alpha: 1.0)
	public static let white: Color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	public static let snow: Color = #colorLiteral(red: 1.0, green: 0.9803921568627451, blue: 0.9803921568627451, alpha: 1.0)
	public static let honeydew: Color = #colorLiteral(red: 0.9411764705882353, green: 1.0, blue: 0.9411764705882353, alpha: 1.0)
	public static let mintCream: Color = #colorLiteral(red: 0.9607843137254902, green: 1.0, blue: 0.9803921568627451, alpha: 1.0)
	public static let azure: Color = #colorLiteral(red: 0.9411764705882353, green: 1.0, blue: 1.0, alpha: 1.0)
	public static let aliceBlue: Color = #colorLiteral(red: 0.9411764705882353, green: 0.9725490196078431, blue: 1.0, alpha: 1.0)
	public static let ghostWhite: Color = #colorLiteral(red: 0.9725490196078431, green: 0.9725490196078431, blue: 1.0, alpha: 1.0)
	public static let whiteSmoke: Color = #colorLiteral(red: 0.9607843137254902, green: 0.9607843137254902, blue: 0.9607843137254902, alpha: 1.0)
	public static let seashell: Color = #colorLiteral(red: 1.0, green: 0.9607843137254902, blue: 0.9333333333333333, alpha: 1.0)
	public static let beige: Color = #colorLiteral(red: 0.9607843137254902, green: 0.9607843137254902, blue: 0.8627450980392157, alpha: 1.0)
	public static let oldLace: Color = #colorLiteral(red: 0.9921568627450981, green: 0.9607843137254902, blue: 0.9019607843137255, alpha: 1.0)
	public static let floralWhite: Color = #colorLiteral(red: 1.0, green: 0.9803921568627451, blue: 0.9411764705882353, alpha: 1.0)
	public static let ivory: Color = #colorLiteral(red: 1.0, green: 1.0, blue: 0.9411764705882353, alpha: 1.0)
	public static let antiqueWhite: Color = #colorLiteral(red: 0.9803921568627451, green: 0.9215686274509803, blue: 0.8431372549019608, alpha: 1.0)
	public static let linen: Color = #colorLiteral(red: 0.9803921568627451, green: 0.9411764705882353, blue: 0.9019607843137255, alpha: 1.0)
	public static let lavendarBlush: Color = #colorLiteral(red: 1.0, green: 0.9411764705882353, blue: 0.9607843137254902, alpha: 1.0)
	public static let mistyRose: Color = #colorLiteral(red: 1.0, green: 0.8941176470588236, blue: 0.8823529411764706, alpha: 1.0)
	public static let gainsboro: Color = #colorLiteral(red: 0.8627450980392157, green: 0.8627450980392157, blue: 0.8627450980392157, alpha: 1.0)
	public static let lightGray: Color = #colorLiteral(red: 0.8274509803921568, green: 0.8274509803921568, blue: 0.8274509803921568, alpha: 1.0)
	public static let silver: Color = #colorLiteral(red: 0.7529411764705882, green: 0.7529411764705882, blue: 0.7529411764705882, alpha: 1.0)
	public static let darkGray: Color = #colorLiteral(red: 0.6627450980392157, green: 0.6627450980392157, blue: 0.6627450980392157, alpha: 1.0)
	public static let gray: Color = #colorLiteral(red: 0.5019607843137255, green: 0.5019607843137255, blue: 0.5019607843137255, alpha: 1.0)
	public static let dimGray: Color = #colorLiteral(red: 0.4117647058823529, green: 0.4117647058823529, blue: 0.4117647058823529, alpha: 1.0)
	public static let lightSlateGray: Color = #colorLiteral(red: 0.4666666666666667, green: 0.5333333333333333, blue: 0.6, alpha: 1.0)
	public static let slateGray: Color = #colorLiteral(red: 0.4392156862745098, green: 0.5019607843137255, blue: 0.5647058823529412, alpha: 1.0)
	public static let darkSlateGray: Color = #colorLiteral(red: 0.1843137254901961, green: 0.30980392156862746, blue: 0.30980392156862746, alpha: 1.0)
	public static let black: Color = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
	
    public init(white: CGFloat, alpha: CGFloat = 1.0) {
        uiColor = UIColor(white: white, alpha: alpha)
    }
    
    public init(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1.0) {
        uiColor = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: CGFloat(alpha))
    }
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        uiColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    internal init(uiColor: UIColor) {
        self.uiColor = uiColor
    }
    
    public required convenience init(_colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
 
    /// Creates a new, lighter color
    ///
    /// - Parameter percent: A percentage value to lighten the color. Specify a number from `0.0` to `1.0`.
    /// - localizationKey: Color.lighter
    public func lighter(percent: Double = 0.2) -> Color {
        return withBrightness(percent: 1 + percent)
    }
    
    /// Creates a new Color with the given transparency.
    ///
    /// - Parameter alpha: A percentage value for the transparency of the new Color. Specify a number from `0.0` to `1.0`.
    ///   - `0.0` is completely transparent, and so is invisible.
    ///   - `1.0` is completely opaque.
    /// - localizationKey: Color.withAlpha
    public func withAlpha(alpha: Double) -> Color {
        return Color(uiColor: uiColor.withAlphaComponent(CGFloat(alpha)))
    }
    
    /// Creates a new, darker color.
    ///
    /// - Parameter percent: A percentage value to darken the color. Specify a number from `0.0` to `1.0`.
    /// - localizationKey: Color.darker
    public func darker(percent: Double = 0.2) -> Color {
        return withBrightness(percent: 1 - percent)
    }
    
    /// Creates a new Color with the given brightness.
    ///
    /// - Parameter percent: A percentage value to brighten the color. Specify a number from `0.0` to `1.0`.
    ///   - `0.0` is the darkest setting
    ///   - `1.0` is the brightest setting
    /// - localizationKey: Color.withBrightness(percent:)
    private func withBrightness(percent: Double) -> Color {
        var cappedPercent = min(percent, 1.0)
        cappedPercent = max(0.0, percent)
        
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness) * cappedPercent, alpha: Double(alpha))
    }
    
    /// Pick a random color.
    ///
    /// An opaque color with random red, green and blue values will be selected.
    /// - localizationKey: Color.random()
    public static func random() -> Color {
        let uint32MaxAsFloat = Float(UInt32.max)
        let red = Double(Float(arc4random()) / uint32MaxAsFloat)
        let blue = Double(Float(arc4random()) / uint32MaxAsFloat)
        let green = Double(Float(arc4random()) / uint32MaxAsFloat)
        
        return Color(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

//public typealias _ColorLiteralType = Color

public func ==(left: Color, right: Color) -> Bool {
    return left.uiColor == right.uiColor
}

extension Color: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return uiColor
        }
    }
}

public extension UIColor {
	var color: Color {
		return Color(uiColor: self)
	}
}
