//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Dilpreet Singh on 04/07/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet private weak var topDisplay: UILabel! //To display the expression
    @IBOutlet private weak var display: UILabel! //To display the currently entered number and/or result
    
    var topDisplayValue: String {
        get {
            return topDisplay.text ?? ""
        }
        set {
            topDisplay.text = newValue
        }
    }
    
    private var displayValue: String {
        get {
            return display.text ?? ""
        }
        set {
            display.text = newValue
        }
    }
    
    private var IP = InternalProgram()
    
    private var digitEnteredAfterEquals = false
    private var valueStoredInM = false
    private var userIsInTheMiddleOfTypingNumber = false
    private var lastOperationEntered = ""
    
    @IBAction func undo(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber{
            if (displayValue != ""){
                displayValue = displayValue.substringToIndex(displayValue.endIndex.predecessor())
                topDisplayValue = IP.updateResult()
                
            }
            if displayValue == ""{
                userIsInTheMiddleOfTypingNumber = false
            }
        } else
        {
            if !IP.internalProgram.isEmpty {
                IP.internalProgram.removeLast()
                topDisplayValue = IP.updateResult()
            }
        }
    }
    //accumulate a complete number
    @IBAction func touchDigit(sender: UIButton ) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            if (digit == "." && !displayValue.containsString(".")) {
                displayValue += digit
            }  else if (Double(digit) != nil) && !displayValue.containsString("M") {
                displayValue += digit
            }
        } else {
            displayValue = digit
            userIsInTheMiddleOfTypingNumber = true
            if lastOperationEntered == "=" {
                digitEnteredAfterEquals = true
                IP.internalProgram.removeAll()
            } else {
                digitEnteredAfterEquals = false
            }
        }
    }
    
    //Perform the selected operation and display the result
    @IBAction func performOperation(sender: UIButton) {
        let binaryOps = ["×","÷","+","−","%","^","=",""]
        let button = sender.currentTitle!
        
        if digitEnteredAfterEquals  {
            // clear when digit is entered after any result
            topDisplayValue = ""
        }
        
        if userIsInTheMiddleOfTypingNumber {
            if displayValue != "M"{
                if !valueStoredInM {
                    if !binaryOps.contains(lastOperationEntered){
                        IP.clear()
                    }
                    if displayValue != ""{
                        IP.storeOperand(Double(displayValue)!)
                    }
                    topDisplayValue = IP.updateResult()
                } else{
                    valueStoredInM = false
                }
            } else{
                IP.storeVariable("M")
            }
            topDisplayValue = IP.updateResult()
        }
        
        if let mathSymbol = sender.currentTitle {
            IP.storeOperator(mathSymbol)
        }
        
        lastOperationEntered = button
        displayValue = String(IP.evaluate())
        topDisplayValue = IP.updateResult()
        userIsInTheMiddleOfTypingNumber = false
    }
    
    @IBAction func storeValueInM(sender: UIButton) {
        valueStoredInM = true
        lastOperationEntered = "→M"
        IP.setVariableValues("M", value: Double(displayValue) ?? 0.0)
        displayValue = String(IP.evaluate())
        displayValue = ""
    }
    
    //Bring the calculator to its initial state as it was in the start
    @IBAction func clear() {
        displayValue = "0"
        topDisplayValue = ""
        userIsInTheMiddleOfTypingNumber = false
        digitEnteredAfterEquals = false
        IP.clear()
    }
}