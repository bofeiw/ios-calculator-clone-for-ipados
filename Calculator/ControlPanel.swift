//
//  ControlPanel.swift
//  Calculator
//  Displays all control buttons including numbers and operators
//
//  Created by Bofei Wang on 29/4/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import SwiftUI

// the size and gap of buttons, to be calculated in run time based on screen size
var buttonGapSize: CGFloat = 0
var buttonSize: CGFloat = 0

// the strategy to calculate the size of buttons, is to find the shortest side of the screen (height or width) and divide the total screen length by 7 (5 row of buttons + 2 rows of spacing)
func calculateButtonSizes() {
    buttonGapSize =
        (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ?
            (UIScreen.main.bounds.width / 50) :
        (UIScreen.main.bounds.height / 50)
    
    buttonSize =
        (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ?
            ((UIScreen.main.bounds.width - 4 * buttonGapSize) / 7):
        ((UIScreen.main.bounds.height - 4 * buttonGapSize) / 7)
    
    print(buttonSize)
}

// add a initialiser by hex color
// https://stackoverflow.com/a/56894458/12208834
extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

struct ControlPanel: View {
    private let BGGray = Color(hex: 0xa5a5a5)
    private let BGHoverGray = Color(hex: 0xd9d9d9)
    
    private let BGDarkGray = Color(hex: 0x333333)
    private let BGHoverDarkGray = Color(hex: 0x737373)
    
    private let BGOrange = Color(hex: 0xff9f06)
    private let BGHoverOrange = Color(hex: 0xfcc88d)
    
    private let FGWhite = Color(.white)
    private let FGBlack = Color(.black)
    
    var body: some View {
        // here are a list of 5 rows of buttons, each row of button includes the specific buttons, and defines their symbol, colors and all of its properties
        VStack(spacing: buttonGapSize) {
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "AC", BG: BGGray, FG: FGBlack, BGHover: BGHoverGray)
                CalculatorButton(image: Image(systemName: "plus.slash.minus"), BG: BGGray, FG: FGBlack, BGHover: BGHoverGray)
                CalculatorButton(text: "%", BG: BGGray, FG: FGBlack, BGHover: BGHoverGray)
                CalculatorButton(image: Image(systemName: "divide"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "7", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(text: "8", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(text: "9", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(image: Image(systemName: "multiply"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "4", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(text: "5", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(text: "6", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(image: Image(systemName: "minus"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "1", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(text: "2", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(text: "3", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(image: Image(systemName: "plus"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(text: "0", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray, horizontalSpan: 2)
                CalculatorButton(text: ".", BG: BGDarkGray, FG: FGWhite, BGHover: BGHoverDarkGray)
                CalculatorButton(image: Image(systemName: "equal"), BG: BGOrange, FG: FGWhite, BGHover: BGHoverOrange)
            }
        }
    }
    
    init() {
        // calculate the button size on init
        calculateButtonSizes()
    }  
}


struct ControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanel()
    }
}
