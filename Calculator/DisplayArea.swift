//
//  DisplayArea.swift
//  Calculator
//
//  Created by Bofei Wang on 29/4/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import SwiftUI

struct DisplayArea: View {
    @State var currentDisplay = "0"
    
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
