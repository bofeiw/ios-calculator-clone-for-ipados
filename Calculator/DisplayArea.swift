//
//  DisplayArea.swift
//  Calculator
//
//  Created by Bofei Wang on 29/4/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import SwiftUI

enum DisplayAreaEvent {
    case Delete
    case CopyToClipBoard
}

// display area displays current result
struct DisplayArea: View {
    var eventCallback: ((DisplayAreaEvent) -> Void)?
    
    // bindind display text from calculator
    @Binding var currentDisplay: String
    
    var body: some View {
        Text(currentDisplay)
            .font(.system(size: 100))
    }
}

struct DisplayArea_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
