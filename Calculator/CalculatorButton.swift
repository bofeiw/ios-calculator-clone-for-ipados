//
//  Button.swift
//  Calculator button, implements a specific single button based on the custom properties
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
    
    // optionally to have an symbol image. if the image is given, use the image. otherwise a symbol text must be given
    var symbolImage: Image?
    var symbolText: String = ""
    
    // background and foreground colors, can be customised
    var backgroundColor: Color = .gray
    var foregroundColor: Color = .white
    
    // the number of columns it spans. by default the width is 1 unit of button. Must be an integer. customisation is optional, only customise it when you know what you are doing
    // e.g. if the span is 2, it spans to 2 units of button widths. an example is the "0" button of the calculator that spans 2 units.
    var horizontalSpan: CGFloat = 1.0
    
    
    var body: some View {
        // the button is a stacked view that implements the background at the bottom and image or text at the top
        ZStack(alignment: .leading) {
            // by default the background is a circle when the span is 1
            // if the span is more than 1, it becomes a rectangle with half circles on the left and right
            Text("")
                .cornerRadius(buttonSize / 2)
                .frame(width: (buttonSize * horizontalSpan + (horizontalSpan - 1) * buttonGapSize), height: buttonSize)
                .background(backgroundColor)
                .cornerRadius(buttonSize / 2)
                .onTapGesture {
                    print("button clicked")
            }
            Group {
                // use image if given, otherwise use text
                // dont think too much about these magic numbers, they are adjusted to fit the sizes of images and texts so that they look like to have a same size
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
