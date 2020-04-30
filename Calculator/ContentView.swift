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
    var displayArea = DisplayArea()
    var controlPanel = ControlPanel()
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 30.0){
            Spacer()
            Spacer()
            displayArea.padding(.trailing)
            controlPanel.padding(.bottom)
            Spacer()
        }
    }
}

// this is the root view. it includes calculator
struct ContentView: View {
    var body: some View {
        CalculatorView()
    }
    
    static func onCalculateButtonClick() {
        print("calculate clicked")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
