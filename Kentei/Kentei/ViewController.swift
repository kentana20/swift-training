//
//  ViewController.swift
//  Kentei
//
//  Created by kensuke tanaka on 11/8/15.
//  Copyright © 2015 kentana20. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    @IBOutlet weak var logoImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var bodyTextView: UITextView!
//    @IBOutlet weak var startbutton: UIButton!
//    @IBOutlet weak var creditLabel: UILabel!

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var creditLabel: UILabel!
    
    var soundManager = SEManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let csvArray = loadCSV("csv/start")
        
        let img:UIImage = UIImage(named:"images/\(csvArray[0])")!
        logoImageView.image = img
        titleLabel.text = csvArray[1]
        bodyTextView.text = csvArray[2]
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        creditLabel.text = csvArray[3]
        
    }
    
    func loadCSV(filename: String) -> [String] {
        var csvArray = []
        let csvBundle = NSBundle.mainBundle().pathForResource(filename, ofType: "csv")

        do {
            let csvData = try String(contentsOfFile: csvBundle!, encoding: NSUTF8StringEncoding)
            let lineChange = csvData.stringByReplacingOccurrencesOfString("\r", withString: "\n")
            csvArray = lineChange.componentsSeparatedByString("\n")
        }
        catch {
            print("csv load error!!")
        }
        
        return csvArray as! [String]
        
    }
    
    @IBAction func startQuiz(sender: UIButton) {
        soundManager.sePlay("se/kininaru.mp3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

