//
//  ViewController.swift
//  Calculator
//
//  Created by Hsomot Siu on 12/26/21.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var calculatorWorking: UILabel!
    
    @IBOutlet weak var calculatorResult: UILabel!
    
    // Creating empty string to keep our of my working proplems and results string
    // "didSet" let me do something after the value has changed, by setting calculatorWorking.text =  working it will give me an empty string when I open the calculator

    var workings = "" {
        didSet {    
            calculatorWorking.text = workings
        }
    }
    var result = "" {
        didSet {
            calculatorResult.text = result
        }
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        clearAll()
    }
    
    
    // A function to clear all by just set back my workings and result an empty string
    func clearAll(){
        workings = ""
        result = ""
    }
    // This function will add value to my workings, and it's going to take a string value
    func addToWorking(value: String){
        workings = workings + value
        
    }
    
    // This function will do the math, and put the result into double, so that we can cast the double result into a String.
    //https://stackoverflow.com/questions/24704028/nsexpression-calculator-in-swift
    
    @IBAction func equalButon(_ sender: Any) {
        
        let expression = NSExpression(format: workings)
        let resultNumber = expression.expressionValue(with: nil, context: nil) as! Double
        result = formatResult(result: resultNumber)
        
    }
    // This turn our double result from equal button into String
    //https://stackoverflow.com/questions/31390466/swift-how-to-remove-a-decimal-from-a-float-if-the-decimal-is-equal-to-0
    
    
    func formatResult(result: Double) -> String{
        if(result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }
        else{
            return String(format: "%.2f", result)
        }
    }
    
    // This fucntion will split string on my calculatorWorking.text by the "" and check if the last value is a number or contains the given string "sprt" and return, but if it's other operation like /,+,-,* it will return nil
    //https://stackoverflow.com/questions/25678373/split-a-string-into-an-array-in-swift
    // "guard" statement used for when a certain conditions are not met for early exist to prevent crashing
    
    func isLastValueANumber() -> String?{
        let components = calculatorWorking.text!.components(separatedBy: "" )
        guard
            let lastValue = components.last,
            lastValue.isNumber || lastValue.contains("sqrt")
        else {
            return nil
        }
        return lastValue
    }
    
    
    // input my clear all func here in the buttton
    @IBAction func allClearButton(_ sender: Any) {
        clearAll()
    }
    
    
    
    @IBAction func squareRootButton(_ sender: Any) {
        guard result.isEmpty else {
            workings = "sqrt(\(result))"
            result = ""
            return
        }
        
        // For every function I have separeted the space between the operations like " / " for it pick up the last array after the the space
        // This is handling the last element of the array, to access to the last element of the array we need to have the total count of the array - 1, because array start with 0
        //https://www.codegrepper.com/code-examples/swift/check+if+arrray+last+item+swift
        //https://stackoverflow.com/questions/51209600/swift-how-can-i-check-if-i-iterate-through-the-last-item-of-liststring
        //https://stackoverflow.com/questions/31146467/easiest-way-to-find-square-root-in-swift
        
        var components = workings.components(separatedBy: " ")
        if
            let last = components.last,
            last.isNumber
        {
            components[components.count - 1] = "sqrt(\(last))"
        }
        //Returns the concatenate elements of this sequence by inserting the given separator between each element like the space between the operations like " / "
        // https://developer.apple.com/documentation/swift/array/1690077-joined
        
        workings = components.joined(separator: " ")
        
    }
    
    // As for every function I have separeted the space between the operations like " / " for it pick up the last array after the the space, I write a statement to check if the value array absent, since the array is optional it can be nil, even though in this case it's not supposed to be absent so i used !
    
    @IBAction func divideButton(_ sender: Any) {
        if isLastValueANumber() == nil { return }
        if !result.isEmpty {
            workings = result + " / "
            result = ""
        } else {
            workings += " / "
        }
    }
    
    
    @IBAction func multiplyButton(_ sender: Any) {
        if isLastValueANumber() == nil { return }
        if !result.isEmpty {
            workings = result + " * "
            result = ""
        } else {
            workings += " * "
        }
    }
    
    
    @IBAction func minusButton(_ sender: Any) {
        if isLastValueANumber() == nil { return }
        if !result.isEmpty {
            workings = result + " - "
            result = ""
        } else {
            workings += " - "
        }
    }
    
    
    @IBAction func plusButton(_ sender: Any) {
        if isLastValueANumber() == nil { return }
        if !result.isEmpty {
            workings = result + " + "
            result = ""
        } else {
            workings += " + "
        }
    }
    
    
    @IBAction func numberZeroButton(_ sender: Any) {
        addToWorking(value: "0")
        
    }
    
    
    @IBAction func numberOneButton(_ sender: Any) {
        addToWorking(value: "1")
    }
    
    
    @IBAction func numberTwoButton(_ sender: Any) {
        addToWorking(value: "2")
    }
    
    
    @IBAction func numberThreeButton(_ sender: Any) {
        addToWorking(value: "3")
    }
    
    
    @IBAction func numberFourButton(_ sender: Any) {
        addToWorking(value: "4")
    }
    
    
    @IBAction func numberFiveButton(_ sender: Any) {
        addToWorking(value: "5")
    }
    
    
    @IBAction func numberSixButton(_ sender: Any) {
        addToWorking(value: "6")
    }
    
    
    @IBAction func numberSevenButton(_ sender: Any) {
        addToWorking(value: "7")
    }
    
    @IBAction func numberEightButton(_ sender: Any) {
        addToWorking(value: "8")
    }
    
    
    @IBAction func numberNineButton(_ sender: Any) {
        addToWorking(value: "9")
    }
}

// This function will help to iterate each and check those array string is an number or not for my squareroot function to isLastValueANumber function.
//https://stackoverflow.com/questions/26545166/how-to-check-is-a-string-or-number
extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}


// I did watch this video as a helpful resource to finish my project and some helps to guide me with my logic and algorithm to get back on track
//https://www.youtube.com/watch?v=A2gGNTKo_q8&t=38s
