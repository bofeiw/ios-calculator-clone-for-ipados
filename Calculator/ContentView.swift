//
//  ContentView.swift
//  Calculator
//
//  Created by Bofei Wang on 25/4/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import SwiftUI

// calculator view splits to two main areas, display area at the top and control pannel at the bottom
// there are 2 units of space above the calculator and 1 unit of space below
struct CalculatorView: View {
    @State var currentDisplay = "0"
    
    @State private var calculator = CalculatorModel()
    
    @State private var isDraggingHandled = false
    
    // callback functoin when user interacts with display area
    private func onDisplayAreaClick(_ event: DisplayAreaEvent) -> Void {
        print(event)
    }
    
    private func onDelete() {
        calculator.onDelete()
        currentDisplay = calculator.displayedValue
    }
    
    // callback function when user clicks a button in control panel
    private func onControlPanelClick(_ keyType: ButtonType) -> Void {
        switch keyType {
        case .Plus, .Minus, .Multiply, .Divide:
            calculator.onSelectOperator(keyType)
        case .Number0:
            calculator.onTypeNumber(0)
        case .Number1:
            calculator.onTypeNumber(1)
        case .Number2:
            calculator.onTypeNumber(2)
        case .Number3:
            calculator.onTypeNumber(3)
        case .Number4:
            calculator.onTypeNumber(4)
        case .Number5:
            calculator.onTypeNumber(5)
        case .Number6:
            calculator.onTypeNumber(6)
        case .Number7:
            calculator.onTypeNumber(7)
        case .Number8:
            calculator.onTypeNumber(8)
        case .Number9:
            calculator.onTypeNumber(9)
        case .Dot:
            calculator.onTypeDot()
        case .Calculate:
            calculator.onCalculate()
        case .AC:
            calculator.onAC()
        case .PlusMinus:
            calculator.onPlusMinus()
        case .Percentage:
            calculator.onPercentage()
        }
        currentDisplay = calculator.displayedValue
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 30.0){
            Spacer()
            Spacer()
            HStack() {
                Spacer()
                DisplayArea(eventCallback: onDisplayAreaClick, currentDisplay: $currentDisplay)
            }
            .padding(.trailing)
            .frame(maxWidth: controlPanelWidth)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: buttonSize)
                    .onChanged({ value in
                        print(1)
                        guard !self.isDraggingHandled else {
                            return
                        }
                        guard abs(value.location.y - value.startLocation.y) < buttonSize else {
                            return
                        }
                        self.isDraggingHandled = true
                        self.onDelete()
                    })
                    .onEnded({ _ in
                        self.isDraggingHandled = false
                    })
            )
            ControlPanel(clickCallback: onControlPanelClick).padding(.bottom)
            Spacer()
        }
    }
}

// this is the root view. it includes calculator
struct ContentView: View {
    var body: some View {
        CalculatorView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
