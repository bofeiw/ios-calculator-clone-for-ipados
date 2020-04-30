//
//  Button.swift
//  Calculator button, implements a specific single button based on the custom properties
//
//  Created by Bofei Wang on 29/4/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import SwiftUI

enum TouchState {
    case none, began, moved, ended
    var name: String {
        return "\(self)"
    }
}

struct CalculatorButton: View {
    enum CalculatorButtonType {
        case Plus
        case Minus
        case Multiply
    }
    
    // optionally to have an symbol image. if the image is given, use the image. otherwise a symbol text must be given
    var image: Image?
    var text: String = ""
    
    // background and foreground colors, can be customised
    var BG: Color = .gray
    var FG: Color = .white
    
    // animated on click colors, optional
    // if not provided, the foregroundColor/backgroundColor will be used instead so no color animations will be observed
    var BGHover: Color?
    var FGHover: Color?
    
    // the number of columns it spans. by default the width is 1 unit of button. Must be an integer. customisation is optional, only customise it when you know what you are doing
    // e.g. if the span is 2, it spans to 2 units of button widths. an example is the "0" button of the calculator that spans 2 units.
    var horizontalSpan: CGFloat = 1.0
    
    @State private var isTouching = false
    
    var spannedWidth: CGFloat {
        get {
            buttonSize * horizontalSpan + (horizontalSpan - 1) * buttonGapSize
        }
    }
    
    
    
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            // by default the background is a circle when the span is 1
            // if the span is more than 1, it becomes a rectangle with half circles on the left and right
            Text("")
                .cornerRadius(buttonSize / 2)
                .frame(width: spannedWidth, height: buttonSize)
                .background(self.isTouching ? (BGHover ?? BG) : BG)
                .animation(self.isTouching ? nil : .spring())
                .cornerRadius(buttonSize / 2)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ (touch) in
                            let isOutsideView = (touch.location.y < 0 || touch.location.x < 0 || touch.location.y > buttonSize || touch.location.x > self.spannedWidth)
                            let isIntsideView = (touch.location.y >= 0 && touch.location.x >= 0 && touch.location.y <= buttonSize && touch.location.x <= self.spannedWidth)
                            if self.isTouching && isOutsideView {
                                self.onMoveOutView()
                            } else if !self.isTouching && isIntsideView {
                                self.onMoveIntoView()
                            }
                        })
                        .onEnded({ (touch) in
                            self.onMoveEnd()
                            }
                    )
            )
            Group {
                // use image if given, otherwise use text
                // dont think too much about these magic numbers, they are adjusted to fit the sizes of images and texts so that they look like to have a same size
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonSize / 3, height: buttonSize / 3)
                        .padding(buttonSize / 3)
                        .foregroundColor(FG)
                    
                } else {
                    Text(text)
                        .frame(width: buttonSize / 2, height: buttonSize / 2)
                        .font(.system(size: 500))
                        .minimumScaleFactor(0.01)
                        .padding(buttonSize / 4)
                        .foregroundColor(FG)
                }
            }
        }
    }
    
    private func onMoveIntoView() {
        self.isTouching = true
        print("move in ")
    }
    
    private func onMoveOutView() {
        self.isTouching = false
        print("move out ")
    }
    
    private func onMoveEnd() {
        print("move end")
        self.isTouching = false
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanel()
    }
}
