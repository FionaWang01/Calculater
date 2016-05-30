//
//  ViewController.swift
//  Calculater
//
//  Created by babykang on 16/3/3.
//  Copyright © 2016年 wangkang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var numberShow: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    
    @IBAction func selectNumber(sender: UIButton) {
        let digit = sender.currentTitle
        if userIsInTheMiddleOfTypingANumber{
        numberShow.text = numberShow.text! + digit!
        }else{
            numberShow.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }

    }
    
    // enter key
    
    var items = [Double]()
    
    var brain = CalcultorBrain()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperate(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    var displayValue: Double{
        get {
            return NSNumberFormatter().numberFromString(numberShow.text!)!.doubleValue
            
        }
        set{
            //let newValue = ""
            numberShow.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            
        }
    }
    
    // + ,-, *, / operation
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperate(operation){
                displayValue = result
            }else {
                displayValue = 0 
            }
        }
    }
    
    func performOperate (operation: (Double, Double)->Double){
        if items.count >= 2{
            displayValue = operation (items.removeLast() ,items.removeLast())
            enter()
        }
    }

    func performOperateSingle(operation: Double -> Double){
        if items.count >= 1 {
            displayValue = operation (items.removeLast())
            enter()
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
