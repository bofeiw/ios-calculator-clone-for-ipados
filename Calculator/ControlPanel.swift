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
            (UIScreen.main.bounds.width / 100) :
            (UIScreen.main.bounds.height / 100)

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
    private let buttonGrayBG = Color(hex: 0xa5a5a5)
    private let buttonDarkGrayBG = Color(hex: 0x333333)
    private let buttonOrangeBG = Color(hex: 0xff9f06)
    private let buttonWhiteFG = Color(.white)
    private let buttonBlackFG = Color(.black)
    
    var body: some View {
        // here are a list of 5 rows of buttons, each row of button includes the specific buttons, and defines their symbol, colors and all of its properties
        VStack(spacing: buttonGapSize) {
            HStack(spacing: buttonGapSize) {
                CalculatorButton(symbolText: "AC", backgroundColor: buttonGrayBG, foregroundColor: buttonBlackFG)
                CalculatorButton(symbolImage: Image(systemName: "plus.slash.minus"), backgroundColor: buttonGrayBG, foregroundColor: buttonBlackFG)
                CalculatorButton(symbolText: "%", backgroundColor: buttonGrayBG, foregroundColor: buttonBlackFG)
                CalculatorButton(symbolImage: Image(systemName: "divide"), backgroundColor: buttonOrangeBG, foregroundColor: buttonWhiteFG)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(symbolText: "7", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolText: "8", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolText: "9", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolImage: Image(systemName: "multiply"), backgroundColor: buttonOrangeBG, foregroundColor: buttonWhiteFG)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(symbolText: "4", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolText: "5", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolText: "6", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolImage: Image(systemName: "minus"), backgroundColor: buttonOrangeBG, foregroundColor: buttonWhiteFG)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(symbolText: "1", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolText: "2", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolText: "3", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolImage: Image(systemName: "plus"), backgroundColor: buttonOrangeBG, foregroundColor: buttonWhiteFG)
            }
            HStack(spacing: buttonGapSize) {
                CalculatorButton(symbolText: "0", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG, horizontalSpan: 2)
                CalculatorButton(symbolText: ".", backgroundColor: buttonDarkGrayBG, foregroundColor: buttonWhiteFG)
                CalculatorButton(symbolImage: Image(systemName: "equal"), backgroundColor: buttonOrangeBG, foregroundColor: buttonWhiteFG)
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
