//
//  ViewController.swift
//  calculator-swift
//
//  Created by Liang Chen on 10/02/2016.
//  Copyright © 2016 Liangchen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Muliply = "*"
        case subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!

    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftStr = "" //运算符左面
    var rightStr = "" //运算符右面
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            //btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"    //We can get the tag of each button
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
    
        processOperation(Operation.Divide)
    
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        
        processOperation(Operation.Muliply)
        
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        
        processOperation(Operation.subtract)
        
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        
        processOperation(Operation.Add)
        
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        
        processOperation(currentOperation)
        
    }
    
    func processOperation(op: Operation) {
        
        playSound()
        if currentOperation != Operation.Empty {
            //run some math
            
            if runningNumber != "" {
                
                rightStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Muliply {
                    result = "\(Double(leftStr)! + Double(rightStr)!)"   // convert to double
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftStr)! / Double(rightStr)!)"
                } else if currentOperation == Operation.subtract {
                    result = "\(Double(leftStr)! - Double(rightStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftStr)! + Double(rightStr)!)"
                }
                
                leftStr = result
                outputLbl.text = result
            }
            
            
            
            currentOperation = op
            
        } else {
            //This is the first time an operator has been pressed
            leftStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    


}

