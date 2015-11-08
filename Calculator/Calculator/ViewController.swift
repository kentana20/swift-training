//
//  ViewController.swift
//  Calculator
//
//  Created by kensuke tanaka on 11/8/15.
//  Copyright © 2015 kentana20. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    //計算結果を表示するラベル
    var resultLabel = UILabel()
    let screenWidth: Double = Double(UIScreen.mainScreen().bounds.size.width)
    let screenHeight: Double = Double(UIScreen.mainScreen().bounds.size.height)

    let xButtonCount = 4
    let yButtonCount = 4

    let buttonMargin = 10.0
    
    var number1:Double = 0.0
    var number2:Double = 0.0
    var result:Double = 0.0
    var operatorId:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        
        var resultArea = 0.0
        switch screenHeight {
        case 480:
            resultArea = 200.0
        case 568:
            resultArea = 250.0
        case 667:
            resultArea = 300.0
        case 736:
            resultArea = 350.0
        default:
            resultArea = 0.0
        }
        
        // 計算結果ラベル
        resultLabel.frame = CGRect(x: 10, y: 30,
            width: screenWidth - 20, height: resultArea - 30)
        resultLabel.backgroundColor = UIColor.grayColor()
        resultLabel.font = UIFont(name: "Arial", size: 50)
        resultLabel.textAlignment = NSTextAlignment.Right
        resultLabel.numberOfLines = 4
        resultLabel.text = "0"
        self.view.addSubview(resultLabel)
        
        // ボタン
        let buttonLabels = [
            "7", "8", "9", "x",
            "4", "5", "6", "-",
            "1", "2", "3", "+",
            "0", "C", "/", "="
        ]
        for var y = 0; y < yButtonCount; y++ {
            for var x = 0;x < xButtonCount; x++ {
                let button = UIButton()
                let buttonWidth = (screenWidth - (buttonMargin * (Double(xButtonCount)+1)))
                    / Double(xButtonCount)
                let buttonHeight = (screenHeight - resultArea - ((buttonMargin*Double(yButtonCount)+1))) / Double(yButtonCount)
                let buttonPositionX = (screenWidth - buttonMargin) / Double(xButtonCount) * Double(x) + buttonMargin
                let buttonPositionY = (screenHeight - resultArea - buttonMargin) / Double(yButtonCount) * Double(y) + buttonMargin + resultArea
                button.frame = CGRect(x: buttonPositionX, y: buttonPositionY, width: buttonWidth, height: buttonHeight)
                //button.backgroundColor = UIColor.greenColor()
                let gradient = CAGradientLayer()
                gradient.frame = button.bounds
                let arrayColors = [
                    colorWithRGBHex(0xFFFFFF, alpha: 1.0).CGColor as AnyObject,
                    colorWithRGBHex(0xCCCCCC, alpha: 1.0).CGColor as AnyObject
                ]
                gradient.colors = arrayColors
                button.layer.insertSublayer(gradient, atIndex: 0)
                
                let buttonNumber = y * xButtonCount + x
                button.setTitle(buttonLabels[buttonNumber], forState: UIControlState.Normal)
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 5.0
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)

                button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

                self.view.addSubview(button)
                
            }
        }
        

    }
    
    func buttonTapped(sender:UIButton) {
        let tappedButtonTitle:String = sender.currentTitle!
        print(" \(tappedButtonTitle) ボタンが押された")
        
        switch tappedButtonTitle {
        case "0","1","2","3","4","5","6","7","8","9":
            numberButtonTapped(tappedButtonTitle)
        case "x","-","+","/":
            operatorButtonTapped(tappedButtonTitle)
        case "=":
            equalButtonTapped(tappedButtonTitle)
        default:
            clearButtonTapped(tappedButtonTitle)
        }
    }
    
    func numberButtonTapped(tappedButtonTitle:String) {
        print("数字ボタンタップ: \(tappedButtonTitle)")
        let tappedButtonNum: Double = (tappedButtonTitle as NSString).doubleValue
        number1 = number1 * 10 + tappedButtonNum
        resultLabel.text = NSString(format: "%.0f", number1) as String
    }
    
    func operatorButtonTapped(tappedButtonTitle:String) {
        print("演算子ボタンタップ: \(tappedButtonTitle)")
        operatorId = tappedButtonTitle
        number2 = number1
        number1 = 0
    }
    
    func equalButtonTapped(tappedButtonTitle:String) {
        print("=ボタンタップ: \(tappedButtonTitle)")
        switch operatorId {
        case "+":
            result = number2 + number1
        case "-":
            result = number2 - number1
        case "x":
            result = number2 * number1
        case "/":
            result = number2 / number1
        default:
            print("ほか")
        }
        number1 = result
        resultLabel.text = String("\(result)")
    }
    
    func clearButtonTapped(tappedButtonTitle:String) {
        print("クリアボタンタップ: \(tappedButtonTitle)")
        number1 = 0
        number2 = 0
        result = 0
        operatorId = ""
        resultLabel.text = "0"

    }
    
    func colorWithRGBHex(hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        return UIColor(red: CGFloat(r / 255.0),
            green: CGFloat(g / 255.0),
            blue: CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

