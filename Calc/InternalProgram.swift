//
//  InternalProgram.swift
//  Calc
//
//  Created by Dilpreet Singh on 14/07/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import Foundation

class InternalProgram {
    var description: String = ""
    var internalProgram = [AnyObject]()
    var isPartialResult: Bool = false
    private var variablesDictionary: Dictionary<String, Double> = [:]
    
    private var operationsDictionary: Dictionary<String,Operation> = [
        
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        
        "±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "∛": Operation.UnaryOperation({pow($0, (1 / 3.0) )}),
        "sin" : Operation.UnaryOperation(sin),
        "cos" : Operation.UnaryOperation(cos),
        "tan" : Operation.UnaryOperation(tan),
        "sinh" : Operation.UnaryOperation(sinh),
        "ln" : Operation.UnaryOperation(log),
        "log" : Operation.UnaryOperation(log10),
        "log₂" : Operation.UnaryOperation(log2),
        "^2" : Operation.UnaryOperation({ $0 * $0 }),
        "^3" : Operation.UnaryOperation({ $0 * $0 * $0 }),
        "^-1" : Operation.UnaryOperation({pow($0, -1.0)}),
        "10^" : Operation.UnaryOperation({pow(10.0, $0)}),
        "e^" : Operation.UnaryOperation({pow(M_E, $0)}),
        
        "R" : Operation.RandomNumber(1.0),
        
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $1 / $0 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $1 - $0 }),
        "%" : Operation.BinaryOperation({ $1 % $0 }),
        "^" : Operation.BinaryOperation({pow($1, $0)}),
        "n√" : Operation.BinaryOperation({pow($1, (1 / $0))}),
        
        "=" : Operation.Equals,
        ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case RandomNumber(Double)
    }
    
    func evaluate() -> Double {
        var primaryOperand: Double = 0.0
        var secondaryOperand: Double?
        var closure: ((Double, Double) -> Double)?
        func processOperand(operand: Double) {
            if closure != nil {
                isPartialResult = true
                secondaryOperand = primaryOperand
                primaryOperand = operand
            } else {
                primaryOperand = operand
            }
        }
        
        for obj in internalProgram {
            if obj is Double {
                let operand = obj as! Double
                processOperand(operand)
            } else if obj is String {
                let operationToPerform = obj as! String
                if operationToPerform == "M" {
                    let operand = variablesDictionary["M"] ?? 0.0
                    processOperand(operand)
                } else {
                    let operatorToPerform = operationsDictionary[operationToPerform]
                    switch operatorToPerform! {
                        
                    case Operation.Constant(let value):
                        processOperand(value)
                        
                    case .UnaryOperation(let unaryFunction):
                        primaryOperand = unaryFunction(primaryOperand)
                        
                    case .BinaryOperation(let binaryFunction):
                        if let cl = closure {
                            primaryOperand = cl(primaryOperand, secondaryOperand ?? primaryOperand)
                            secondaryOperand = nil
                        }
                        closure = binaryFunction
                        isPartialResult = true
                        
                    case .Equals:
                        if let cl = closure {
                            primaryOperand = cl(primaryOperand, secondaryOperand ?? primaryOperand)
                            secondaryOperand = nil
                            closure = nil
                            isPartialResult = false
                        }
                        
                    case .RandomNumber(let value):
                        processOperand(value)
                    }
                }
            }
        }
        return primaryOperand
    }
    
    func setVariableValues(name: String, value: Double) {
        variablesDictionary[name] = value
    }
    
    func storeOperand(operand: Double) {
        internalProgram.append(operand)
    }
    
    func storeVariable(operand: String) {
        internalProgram.append(operand)
    }
    
    func storeOperator(op: String) {
        internalProgram.append(op)
    }
    
    
    func updateResult()-> String{
        description = ""
        var currentOperandForUnaryOperation: String?
        var numberOfOperands: Int = 0
        let binaryOps = ["×","÷","+","−","%","^"]
        var lastOperation: String = ""
        for obj in internalProgram{
            if obj is Double{
                numberOfOperands += 1
                currentOperandForUnaryOperation = String(obj)
                description += String(obj)
                lastOperation = ""
            } else if obj is String{
                if obj as! String == "M" {
                    description += "M"
                } else{
                    if description.containsString("=") // Check for "=" in the description
                    {
                        if let rangeOfEquals = description.rangeOfString("=",options: NSStringCompareOptions.CaseInsensitiveSearch) {
                            // If found "=" , remove it from the description
                            description = String(description.characters.prefixUpTo(rangeOfEquals.startIndex))
                        }
                    }
                    if description.containsString("...") // Check for "..." in the description
                    {
                        if let rangeOfDots = description.rangeOfString("...",options: NSStringCompareOptions.CaseInsensitiveSearch) {
                            // If found "..." , remove it from the description
                            description = String(description.characters.prefixUpTo(rangeOfDots.startIndex)) + String(description.characters.suffixFrom(rangeOfDots.endIndex))
                        }
                    }
                    let operation = obj as! String
                    
                    switch operation {
                        
                    case "sinh", "log₂", "log", "sin", "cos", "tan", "10^", "ln", "e^", "√", "±", "∛" :
                        if currentOperandForUnaryOperation == nil{
                            description = operation + "(" + description + ")"
                        } else if currentOperandForUnaryOperation != nil {
                            if description.containsString(currentOperandForUnaryOperation!){
                                if let rangeOfOperator = description.rangeOfString(currentOperandForUnaryOperation!, options: NSStringCompareOptions.BackwardsSearch){
                                    description = String(description.characters.prefixUpTo(rangeOfOperator.startIndex))
                                    description += operation + "(" + currentOperandForUnaryOperation! + ")" + "..."
                                    currentOperandForUnaryOperation = nil
                                }
                            }
                        }
                        
                    case "^2", "^3", "^-1":
                        if currentOperandForUnaryOperation == nil{
                            description = "(" + description + ")" + operation
                        } else if currentOperandForUnaryOperation != nil {
                            if description.containsString(currentOperandForUnaryOperation!){
                                if let rangeOfOperator = description.rangeOfString(currentOperandForUnaryOperation!, options: NSStringCompareOptions.BackwardsSearch){
                                    description = String(description.characters.prefixUpTo(rangeOfOperator.startIndex))
                                    description += "(" + currentOperandForUnaryOperation! + ")" + operation + "..."
                                    currentOperandForUnaryOperation = nil
                                }
                            }
                        }
                        
                    case "+", "−", "×", "÷", "%", "^":
                        if numberOfOperands == 1 {
                            description += operation + "..."
                        } else{
                            description = "(" + description + ")" + operation + "..."
                        }
                        currentOperandForUnaryOperation = nil
                        
                    case "=" :
                        if binaryOps.contains(lastOperation){ // This is for the cases like "7+="
                            description += String(description.characters.prefixUpTo(description.endIndex.predecessor()))
                        }
                        description += "="
                        currentOperandForUnaryOperation = nil
                        
                    case "e", "π":
                        description += operation
                        currentOperandForUnaryOperation = nil
                        
                    default:
                        description += operation
                    }
                    lastOperation = operation
                }
            }
        }
        return description
    }
    
    private func callForDescription() -> String {
        return description
    }
    
    func clear(){
        internalProgram.removeAll()
        variablesDictionary = [:]
        description = ""
    }
}