//
//  ViewController.swift
//  retro-calculator
//
//  Created by Kevin Simon on 20.07.16.
//  Copyright © 2016 Kevin Simon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "empty"
    }
    
    // Outlets
    @IBOutlet weak var label: UILabel!
    
    var buttonSound:AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try buttonSound = AVAudioPlayer(contentsOf: soundURL as URL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(button: UIButton!){
        //playSound()
        
        runningNumber += "\(button.tag)"
        label.text = runningNumber
    }
    
    @IBAction func clearPressed(_ sender: AnyObject){
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        
        label.text = "0.00"
    }
    
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(op: Operation.Multiply)
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(op: Operation.Divide)
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(op: Operation.Add)
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(op: Operation.Subtract)
    }
    
    @IBAction func onEqualsPressed(_ sender: AnyObject) {
        processOperation(op: currentOperation)
    }
    
    func processOperation(op: Operation){
        //playSound()
        
        if currentOperation != Operation.Empty{
            // Math
            
            // User selected an op, but then selected another op without selecting a number
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                
                label.text = result
                
                
            }
            
            currentOperation = op
            
        } else {
            // First Time Operator pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    func playSound(){
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
}




