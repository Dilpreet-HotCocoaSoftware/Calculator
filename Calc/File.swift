////
////  File.swift
////  Calc
////
////  Created by Dilpreet Singh on 04/07/16.
////  Copyright © 2016 Dilpreet Singh. All rights reserved.
////
//
//import Foundation
////    @IBAction func performOperation(sender: UIButton) {
////        if userIsInTheMiddleOfTyping {
////            brain.setOperand(Double(displayValue) ?? 0)
////            userIsInTheMiddleOfTyping = false
////        }
////
////        if let mathSymbol = sender.currentTitle {
////            brain.performOperation(mathSymbol)
////        }
////
////        let button = sender.currentTitle!
////
////        if button == "=" {
////            userIsInTheMiddleOfTyping = false
////            topDisplayValue = brain.description + "="
////            brain.description = ""
////            displayValue = String(brain.result)
////        } else if (
////                button == "log" ||
////                button == "ln" ||
////                button == "√" ||
////                button == "sin" ||
////                button == "cos" ||
////                button == "tan" ||
////                button == "sinh" ||
////                button == "e^" ||
////                button == "10^" ||
////                button == "^-1" ||
////                button == "^2" ||
////                button == "^3" ||
////                button == "rand" )
////        {
////            displayValue = String(brain.result)
////            userIsInTheMiddleOfTyping = false
////            switch button {
////            case "log", "sin", "cos", "tan", "10^" :
////                topDisplayValue = button + "(" + brain.description.substringToIndex(brain.description.endIndex.predecessor().predecessor().predecessor()) + ")"
////            case "sinh":
////                topDisplayValue = button + "(" + brain.description.substringToIndex(brain.description.endIndex.predecessor().predecessor().predecessor().predecessor()) + ")"
////            case "^-1":
////                topDisplayValue = brain.description.substringToIndex(brain.description.endIndex.predecessor().predecessor().predecessor()) + button
////            case "^2", "^3":
////                topDisplayValue = brain.description.substringToIndex(brain.description.endIndex.predecessor().predecessor()) + button
////            case "ln", "e^":
////                topDisplayValue = button + "(" + brain.description.substringToIndex(brain.description.endIndex.predecessor().predecessor()) + ")"
////            case "√":
////                topDisplayValue = button + "(" + brain.description.substringToIndex(brain.description.endIndex.predecessor()) + ")"
////            case "rand":
////                topDisplayValue = brain.description
////            default :
////                break
////            }
////
////        } else {
////            displayValue = String(brain.result)
////            topDisplayValue = "(" + brain.description.substringToIndex(brain.description.endIndex.predecessor()) + ")" + button
////            if brain.isPartialResult{
////                topDisplayValue += "..."
////            }
////        }
////    }
//
//
//--------------------------- For M
//
////    private var i: String = ""
////    private var ijk = 0
////
////    private func decryptDescription () {
////        while (ijk < description.characters.count) {
////            if description.substringToIndex(ijk){
////            }
////        }
////    }
////    private var i: Int = 0
////    private func solveM(){
////        while i <= descriptionText.characters(" & ").count  {
////            i += 1
////        }
////    }
//
////    private func solveM(){
////        internalProgramCopy.append("=")
////        for i in internalProgramCopy{
////            if i is Double {
////                accumulatorCopy = (i as? Double)!
////            }
////            else if i is String {
////                performMOperationAndUpdateResult(i as! String)
////            }
////        }
////    }
////
////    func performMOperationAndUpdateResult(symbol: String)  {
////        performMOperation(symbol)
////        switch symbol {
////        case "log", "sin", "cos", "tan", "10^" :
////            description = symbol + "(" + manipulateDescription(3) + ")"
////        case "sinh", "log₂" :
////            description = symbol + "(" + manipulateDescription(4) + ")"
////        case "^-1":
////            description = manipulateDescription(3) + symbol
////        case "^2", "^3":
////            description = "(" + manipulateDescription(2) + ")" + symbol
////        case "ln", "e^":
////            description = symbol + "(" + manipulateDescription(2) + ")"
////        case "n√":
////            description = manipulateDescription(2) + "√"
////        case "√", "±", "∛":
////            description = symbol + "(" + manipulateDescription(1) + ")"
////        case "rand":
////            description = callForDescription()
////        case "e", "π":
////            description = callForDescription()
////            if isPartialResult{
////                description += "..."
////            }
////        case "^":
////            description = "(" + manipulateDescription(1) + ")" + symbol
////        case "+", "−", "×", "÷", "%":
////            description = callForDescription()
////
////        case "=" :
////            description = callForDescription()
////
////        default :
////            descriptionText = "Unhandled Error"
////        }
////    }
////
////    func performMOperation(symbol: String) {
////        internalProgramCopyToFindM.append(symbol)
////        if let operation = operations[symbol] {
////            switch operation {
////            case .Constant(let value):
////                accumulator = value
////                description += symbol
////
////            case .UnaryOperation(let foo):
////                accumulator = foo(accumulator)
////                description += symbol
////
////            case .BinaryOperation(let function):
////                executePendingBinaryOperation()
////                pending = PendingBinaryFunctionInfo(binaryFunction: function, firstOperand: accumulator)
////                isPartialResult = true
////                description += symbol
////
////            case .Equals:
////                executePendingBinaryOperation()
////
////            case .Dot:
////                executePendingBinaryOperation()
////                description += symbol
////
////            case .RandomNumber(let value):
////                accumulator = drand48()*value
////                description += (String)(accumulator)
////
////            case .M:
////                solveM()
////                description = description + ""
////            }
////        }
////    }
//
////
////  CalcBrain.swift
////  Calc
////
////  Created by Dilpreet Singh on 09/06/16.
////  Copyright © 2016 Dilpreet Singh. All rights reserved.
////
//
//import Foundation
//
//class calculatorBrain {
//    private var accumulator = 0.0
//    private var internalProgram = [AnyObject]() //Stack that stores operands and operators
//    var isPartialResult: Bool = false
//    
//    private var description: String = "" //Reflected in topDisplay, basically used for expressions
//    private var descriptionText: String = ""
//    
//    func setOperand(operand: String) {
//        var value = 0.0
//        if let digit = Double(operand) {
//            value = digit
//            description += (String)(value)
//            descriptionText += " & " + String(value)
//        } else if let variableValue = variableValues[operand] {
//            value = variableValue
//            description += operand
//            descriptionText += " & " + operand
//        } else if variableValues[operand] == nil{
//            value = 0.0
//            variableValues[operand] = value
//            description += operand
//            descriptionText += " & " + operand
//        }
//        
//        accumulator = value
//        internalProgram.append(value)
//    }
//    
//    private var variableValues: Dictionary<String,Double> = [:]
//    
//    func saveVariable(variableName: String) {
//        variableValues[variableName] = 0.0
//    }
//    
//    func setVariableValues(name: String, value: Double) {
//        variableValues[name] = value
//    }
//    
//    func getVariableValue(name: String) -> Double {
//        if variableValues[name] == nil {
//            variableValues[name] = 0.0
//            return 0.0
//        }
//        else{
//            return variableValues[name]!
//        }
//    }
//    
//    private var operations: Dictionary<String,Operation> = [
//        
//        "π" : Operation.Constant(M_PI),
//        "e" : Operation.Constant(M_E),
//        
//        "±" : Operation.UnaryOperation({ -$0 }),
//        "√" : Operation.UnaryOperation(sqrt),
//        "∛": Operation.UnaryOperation({pow($0, (1 / 3.0) )}),
//        "sin" : Operation.UnaryOperation(sin),
//        "cos" : Operation.UnaryOperation(cos),
//        "tan" : Operation.UnaryOperation(tan),
//        "sinh" : Operation.UnaryOperation(sinh),
//        "ln" : Operation.UnaryOperation(log),
//        "log" : Operation.UnaryOperation(log10),
//        "log₂" : Operation.UnaryOperation(log2),
//        "^2" : Operation.UnaryOperation({ $0 * $0 }),
//        "^3" : Operation.UnaryOperation({ $0 * $0 * $0 }),
//        "^-1" : Operation.UnaryOperation({pow($0, -1.0)}),
//        "10^" : Operation.UnaryOperation({pow(10.0, $0)}),
//        "e^" : Operation.UnaryOperation({pow(M_E, $0)}),
//        
//        "rand" : Operation.RandomNumber(1.0),
//        
//        "×" : Operation.BinaryOperation({ $0 * $1 }),
//        "÷" : Operation.BinaryOperation({ $0 / $1 }),
//        "+" : Operation.BinaryOperation({ $0 + $1 }),
//        "−" : Operation.BinaryOperation({ $0 - $1 }),
//        "%" : Operation.BinaryOperation({ $0 % $1 }),
//        "^" : Operation.BinaryOperation({pow($0, $1)}),
//        "n√" : Operation.BinaryOperation({pow($1, (1 / $0))}),
//        
//        "=" : Operation.Equals,
//        "." : Operation.Dot,
//        "→M": Operation.M
//        
//    ]
//    
//    private enum Operation {
//        case Constant(Double)
//        case UnaryOperation((Double) -> Double)
//        case BinaryOperation((Double, Double) -> Double)
//        case Dot
//        case Equals
//        case RandomNumber(Double)
//        case M
//    }
//    
//    func performOperationAndUpdateResult(symbol: String)  {
//        performOperation(symbol)
//        switch symbol {
//        case "log", "sin", "cos", "tan", "10^" :
//            description = symbol + "(" + manipulateDescription(3) + ")"
//        case "sinh", "log₂" :
//            description = symbol + "(" + manipulateDescription(4) + ")"
//        case "^-1":
//            description = manipulateDescription(3) + symbol
//        case "^2", "^3":
//            description = "(" + manipulateDescription(2) + ")" + symbol
//        case "ln", "e^":
//            description = symbol + "(" + manipulateDescription(2) + ")"
//        case "n√":
//            description = manipulateDescription(2) + "√"
//        case "√", "±", "∛":
//            description = symbol + "(" + manipulateDescription(1) + ")"
//        case "rand":
//            description = callForDescription()
//        case "e", "π":
//            description = callForDescription()
//            if isPartialResult{
//                description += "..."
//            }
//        case "^":
//            description = "(" + manipulateDescription(1) + ")" + symbol
//        case "+", "−", "×", "÷", "%":
//            description = callForDescription()
//        case "=" :
//            description = callForDescription()
//            
//        default :
//            descriptionText = "Unhandled Error"
//        }
//    }
//    
//    func performOperation(symbol: String) {
//        internalProgram.append(symbol)
//        if let operation = operations[symbol] {
//            switch operation {
//            case .Constant(let value):
//                accumulator = value
//                description += symbol
//                descriptionText += " & " + symbol
//                
//            case .UnaryOperation(let foo):
//                accumulator = foo(accumulator)
//                description += symbol
//                descriptionText += " & " + symbol
//                
//            case .BinaryOperation(let function):
//                executePendingBinaryOperation()
//                pending = PendingBinaryFunctionInfo(binaryFunction: function, firstOperand: accumulator)
//                isPartialResult = true
//                description += symbol
//                descriptionText += " & " + symbol
//                
//            case .Equals:
//                executePendingBinaryOperation()
//                
//            case .Dot:
//                executePendingBinaryOperation()
//                description += symbol
//                descriptionText += " & " + symbol
//                
//            case .RandomNumber(let value):
//                accumulator = drand48()*value
//                description += (String)(accumulator)
//                descriptionText += " & " + String(accumulator)
//                
//            case .M:
//                description = description + ""
//            }
//        }
//    }
//    
//    
//    
//    private func executePendingBinaryOperation(){
//        if pending != nil {
//            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
//            pending = nil
//        }
//    }
//    
//    private var pending: PendingBinaryFunctionInfo?
//    
//    private struct PendingBinaryFunctionInfo {
//        var binaryFunction: (Double, Double) -> Double
//        var firstOperand: Double
//    }
//    
//    func setDescription(value: String) {
//        description = value
//    }
//    
//    func callForDescription() -> String {
//        return description
//    }
//    
//    func manipulateDescription(n: Int) -> String {
//        switch n {
//        case 1:
//            description = description.substringToIndex(description.endIndex.predecessor())
//        case 2:
//            description = description.substringToIndex(description.endIndex.predecessor().predecessor())
//        case 3:
//            description = description.substringToIndex(description.endIndex.predecessor().predecessor().predecessor())
//        case 4:
//            description = description.substringToIndex(description.endIndex.predecessor().predecessor().predecessor().predecessor())
//        default:
//            break
//        }
//        return description
//    }
//    
//    //clear CalcBrain when C Button is pressed
//    func clear(){
//        accumulator = 0.0
//        pending = nil
//        description = ""
//        descriptionText = ""
//        isPartialResult = false
//        clearInternalProgram()
//    }
//    
//    func clearInternalProgram () {
//        internalProgram.removeAll()
//    }
//    
//    var result: Double {
//        get{
//            return accumulator
//        }
//    }
//}
