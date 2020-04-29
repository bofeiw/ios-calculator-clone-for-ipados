//
//  Button.swift
//  Calculator
//
//  Created by Bofei Wang on 29/4/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import SwiftUI

struct CalculatorButton: View {
    enum CalculatorButtonType {
        case Plus
        case Minus
        case Multiply
    }
    
    var symbolImage: Image?
    var symbolText: String = ""
    var backgroundColor: Color = .gray
    var foregroundColor: Color = .white
    var horizontalSpan: CGFloat = 1.0
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .cornerRadius(buttonSize / 2)
                .frame(width: (buttonSize * horizontalSpan + (horizontalSpan - 1) * buttonGapSize), height: buttonSize)
                .background(backgroundColor)
                .cornerRadius(buttonSize / 2)
                .onTapGesture {
                    print("button clicked")
            }
            Group {
                if symbolImage != nil {
                    symbolImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonSize / 3, height: buttonSize / 3)
                        .padding(buttonSize / 3)
                        .foregroundColor(foregroundColor)
                    
                } else {
                    Text(symbolText)
                    .frame(width: buttonSize / 2, height: buttonSize / 2)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .padding(buttonSize / 4)
                    .foregroundColor(foregroundColor)
                }
            }
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanel()
    }
}
