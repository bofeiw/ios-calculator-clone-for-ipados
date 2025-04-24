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
    private var inputs: String =  ""
    private var isError = false
    private var isNegative = false
    private var lastInput: Double = 0
    private let maxInput = 9
    private let formatterUpperBreakPoint = 999999999.9
    private let formatterLowerBreakPoint = 0.000000001
    private let decimalFormatter = NumberFormatter()
    private let scientificFormatter = NumberFormatter()
    
    init() {
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.maximumIntegerDigits = maxInput
        decimalFormatter.maximumSignificantDigits = maxInput + 1
        scientificFormatter.numberStyle = .scientific
        scientificFormatter.maximumSignificantDigits = maxInput + 1
    }
    
    var displayedValue: String {
        get {
            if isError && inputs.isEmpty {
                return "Error"
            } else if !inputs.isEmpty {
                var parsedInputs = Double(inputs) ?? 0
                guard parsedInputs != 0 else {
                    // e.g. -0.00003
                    if isNegative {
                        return "-" + inputs
                    } else {
                        return inputs
                    }
                }
                if isNegative {
                    parsedInputs.negate()
                }
                var formattedInputs = decimalFormatter.string(from: NSNumber(value: parsedInputs)) ?? "0"
                if inputs.last == "." {
                    formattedInputs += "."
                }
                return formattedInputs
            } else if inputs.isEmpty && isNegative {
                return "-0"
            } else if ans != 0 {
                if abs(ans) < formatterUpperBreakPoint && abs(ans) > formatterLowerBreakPoint {
                    return decimalFormatter.string(from: NSNumber(value: ans)) ?? "0"
                } else {
                    return scientificFormatter.string(from: NSNumber(value: ans)) ?? "0"
                }
            } else {
                return "0"
            }
        }
    }
    
    var computedValue: Double {
        get {
            0
        }
    }
    
    mutating func onTypeNumber(_ number: Int) {
        print("Input number", number)
        if inputs.isEmpty {
            inputs.append(String(number))
        } else if inputs.count >= maxInput {
            // discard any additional inputs if the pool is full
            // allow one digit if the last input is a dot
            if inputs.last == "." && inputs.count <= maxInput {
                inputs.append(String(number))
            }
        } else {
            inputs.append(String(number))
        }
    }
    
    mutating func onTypeDot() {
        print("dot typed")
        guard !inputs.contains(".") else {
            return
        }
        if inputs.count >= maxInput {
            // discard if pool is full
        } else if inputs.isEmpty {
            inputs.append("0.")
        } else {
            inputs.append(".")
        }
    }
    
    mutating func onAC() {
        print("AC")
        self.ans = 0
        self.inputs.removeAll()
        self.selectedOperator = nil
        self.isNegative = false
        self.isError = false
        self.lastInput = 0
    }
    
    mutating func onSelectOperator(_ selectedOperator: ButtonType) {
        print("operator", selectedOperator)
        self.selectedOperator = selectedOperator
        let inputNumber = Double(inputs) ?? 0
        if inputNumber != 0 {
            ans = inputNumber
        }
        inputs.removeAll()
    }
    
    mutating func onCalculate() {
        print("calculate")
        var inputNumber = Double(inputs) ?? 0
        if isNegative {
            inputNumber.negate()
        }
        
        isNegative = false
        inputs.removeAll()
        
        lastInput = inputNumber

        guard !isError else {
            return
        }
        
        switch selectedOperator {
        case nil:
            ans = lastInput
        case .Plus:
            ans += lastInput
        case .Minus:
            ans -= lastInput
        case .Multiply:
            ans *= lastInput
        case .Divide:
            guard lastInput != 0 else {
                isError = true
                ans = 0
                lastInput = 0
                return
            }
            ans /= lastInput
        default:
            break
        }
    }
    
    mutating func onPlusMinus() {
        print("plusminus")
        if ans != 0 {
            ans = -ans
        } else {
            self.isNegative.toggle()
        }
    }
    
    mutating func onPercentage() {
        print("percentage")
        lastInput = Double(inputs) ?? 0
        if isNegative {
            lastInput.negate()
        }
        
        isNegative = false
        inputs.removeAll()
        
        if lastInput != 0 {
            ans = lastInput / 100
            lastInput = 0
        } else {
            ans /= 100
        }
    }
    
    mutating func onDelete() {
        print("onDelete")
        guard !inputs.isEmpty else {
            return
        }
        _ = inputs.popLast()
        print(inputs)
    }
    
    mutating func onPaste(_ content: String) {
        var parsedContent: Double? = Double(content)
        guard parsedContent != nil else {
            return
        }
        if abs(parsedContent!) > formatterUpperBreakPoint || abs(parsedContent!) < formatterLowerBreakPoint {
            ans = parsedContent!
        } else {
            if parsedContent! < 0 {
                isNegative = true
                parsedContent?.negate()
            }
            inputs = String(parsedContent!).trimmingCharacters(in: CharacterSet.init(charactersIn: ".0"))
        }
        isError = false
    }
    
    private mutating func recordAns() {
        ans = Double(inputs) ?? 0
        if isNegative {
            isNegative = false
            ans = -ans
        }
        markNoError()
    }
    
    private mutating func markNoError() {
        self.isError = false
    }
}
