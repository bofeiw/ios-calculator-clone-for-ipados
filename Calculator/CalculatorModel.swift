//
//  CalculatorModel.swift
//  Calculator Model that does all the calculations under the hood, that provides APIs for views
//
//  Created by Bofei Wang on 1/5/20.
//  Copyright © 2020 bofei. All rights reserved.
//

import Foundation

struct CalculatorModel {
    private var selectedOperator: ButtonType? = nil
    private var ans: Double = 0
    private var inputs: String =  "0"
    private var isError = false
    private var isNegative = false
    
    private var computedInput: Double? {
        get {
            Double(inputs)
        }
    }
    
    var displayedValue: String {
        get {
            inputs
        }
    }
    
    var computedValue: Double {
        get {
            0
        }
    }
    
    mutating func onTypeNumber(_ number: Int) {
        print("Input number", number)
        inputs.append("\(number)")
    }
    
    mutating func onTypeDot() {
        print("dot typed")
        guard inputs.contains(".") else {
            return
        }
        inputs.append(".")
    }
    
    mutating func onAC() {
        print("AC")
        self.ans = 0
        self.inputs.removeAll()
        self.selectedOperator = nil
    }
    
    mutating func onSelectOperator(_ selectedOperator: ButtonType) {
        print("operator", selectedOperator)
        self.selectedOperator = selectedOperator
    }
    
    mutating func onCalculate() {
        print("calculate")
        guard computedInput != nil else {
            self.isError = true
            return
        }
        self.isError = false
        guard selectedOperator != nil else {
            ans = computedInput!
            inputs.removeAll()
            return
        }
        
    }
    
    mutating func onPlusMinus() {
        print("plusminus")
        self.isNegative.toggle()
    }
    
    func onPercentage() {
        print("percentage")
    }
}
