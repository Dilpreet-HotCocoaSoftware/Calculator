//
//  ViewController.swift
//  Calculator
//
//  Created by Dilpreet Singh on 08/06/16.
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
    
    //store a value in M
    func save() {
        brain.saveVariable("M")
        brain.setVariableValues("M", value: Double(displayValue)!)
    }
    
    private var brain = calculatorBrain()
    
    var digitEnteredAfterEquals = false
    var setMIsPressed = false
    
    private var userIsInTheMiddleOfTypingNumber = false
    
    //accumulate a complete number
    @IBAction func touchDigit(sender: UIButton ) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            if (digit == "." && !displayValue.containsString(".")) {
                displayValue += digit
            } else if(digit == "⬅︎"){
                displayValue = displayValue.substringToIndex(displayValue.endIndex.predecessor())
            } else if (Double(digit) != nil) && !displayValue.containsString("M") {
                displayValue += digit
            }
        } else {
            displayValue = digit
            userIsInTheMiddleOfTypingNumber = true
            
            if digitEnteredAfterEquals {
                // clear when digit is entered after any result
                if setMIsPressed == false {
                    brain.clearInternalProgram()
                    brain.setDescription("")
                    topDisplayValue = ""
                }
            }
        }
    }
    
    //Perform the selected operation and display the result
    @IBAction func performOperation(sender: UIButton) {
        let button = sender.currentTitle!
        
        if button != "→M" {
            if userIsInTheMiddleOfTypingNumber {
                brain.setOperand(displayValue)
            }
            
            if let mathSymbol = sender.currentTitle {
                brain.performOperationAndUpdateResult(mathSymbol)
            }
            
            digitEnteredAfterEquals = (button == "=") ? true : false
            topDisplayValue = (button == "=") ? brain.callForDescription() + "=" : brain.callForDescription()
            
        } else if button == "→M" {
            save()
            setMIsPressed = true
            brain.performOperationAndUpdateResult(button)
        }
        
        displayValue = String(brain.result)
        userIsInTheMiddleOfTypingNumber = false
    }
    
    //Bring the calculator to its initial state as it was in the start
    @IBAction func clear() {
        brain.setOperand("")
        brain.clear()
        displayValue = "0"
        topDisplayValue = ""
        userIsInTheMiddleOfTypingNumber = false
        digitEnteredAfterEquals = false
    }
}