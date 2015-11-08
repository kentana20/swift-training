//
//  KenteiViewController.swift
//  Kentei
//
//  Created by kensuke tanaka on 11/8/15.
//  Copyright © 2015 kentana20. All rights reserved.
//

import UIKit

class KenteiViewController: UIViewController {
    // UI部品の変数定義
    @IBOutlet weak var mondaiNumberLabel: UILabel!
    @IBOutlet weak var mondaiTextView: UITextView!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var answerBtn1: UIButton!
    @IBOutlet weak var answerBtn2: UIButton!
    @IBOutlet weak var answerBtn3: UIButton!
    @IBOutlet weak var answerBtn4: UIButton!
    
    var kaisetsuBGImageView = UIImageView()
    var kaisetsuBGX = 0.0
    var seikaiLabel = UILabel()
    var kaisetsuTextView = UITextView()
    var backBtn = UIButton()

    // 変数・定数定義
    var csvArray = [String]()
    var mondaiArray = [String]()
    var mondaiCount = 0
    var correctCount = 0
    let total = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kaisetsuBGImageView.image = UIImage(named: "images/kaisetsuBG.png")
        let screenSize:CGSize = (UIScreen.mainScreen().bounds.size)
        kaisetsuBGX = Double(screenSize.width/2) - 320/2
        kaisetsuBGImageView.frame = CGRect(x: kaisetsuBGX, y: Double(screenSize.height),
            width: 320, height: 210)
        kaisetsuBGImageView.userInteractionEnabled = true
        self.view.addSubview(kaisetsuBGImageView)

        seikaiLabel.frame = CGRect(x: 10, y: 5, width: 300, height: 30)
        seikaiLabel.textAlignment = .Center
        seikaiLabel.font = UIFont.systemFontOfSize(CGFloat(15))
        kaisetsuBGImageView.addSubview(seikaiLabel)
        
        kaisetsuTextView.frame = CGRect(x: 10, y: 40, width: 300, height: 140)
        kaisetsuTextView.backgroundColor = UIColor.clearColor()
        kaisetsuTextView.font = UIFont.systemFontOfSize(CGFloat(17))
        kaisetsuBGImageView.addSubview(kaisetsuTextView)
        
        backBtn.frame = CGRect(x: 10, y: 160, width: 300, height: 30)
        backBtn.setImage(UIImage(named: "images/kenteiBack.png"), forState: .Normal)
        backBtn.setImage(UIImage(named: "images/kenteiBackOn.png"), forState: .Highlighted)
        backBtn.addTarget(self, action: "backBtnTapped",
            forControlEvents: UIControlEvents.TouchUpInside)
        kaisetsuBGImageView.addSubview(backBtn)
        
        // load csv data
        let viewController = ViewController()
        csvArray = viewController.loadCSV("csv/kentei")
        csvArray = quizShuffle()
        // csvで読み込んだデータを元にクイズを描画
        protQuiz()
    }

    // 回答ボタン(1~4)押下時イベント
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(mondaiArray[1]) {
            judgeImageView.image = UIImage(named: "images/maru.png")!
            correctCount++
        } else {
            judgeImageView.image = UIImage(named: "images/batsu.png")!
        }
        judgeImageView.hidden = false
        // 解説表示
        kaisetsu()
    }

    // 次のクイズ
    func nextQuiz() {
        mondaiCount++
        mondaiArray.removeAll(keepCapacity: true)
        if mondaiCount < total {
            protQuiz()
        } else {
            performSegueWithIdentifier("score", sender: nil)
        }
    }
    
    // クイズを画面に描画
    func protQuiz() {
        mondaiArray = csvArray[mondaiCount].componentsSeparatedByString(",")
        mondaiNumberLabel.text = "第\(mondaiCount+1)問"
        mondaiTextView.text = mondaiArray[0]
        answerBtn1.setTitle(mondaiArray[2], forState: .Normal)
        answerBtn2.setTitle(mondaiArray[3], forState: .Normal)
        answerBtn3.setTitle(mondaiArray[4], forState: .Normal)
        answerBtn4.setTitle(mondaiArray[5], forState: .Normal)
    }
    
    // 解説表示
    func kaisetsu() {
        seikaiLabel.text = mondaiArray[6]
        kaisetsuTextView.text = mondaiArray[7]
        let answerBtnY = answerBtn1.frame.origin.y
        UIView.animateWithDuration(0.5, animations: {() ->
            Void in self.kaisetsuBGImageView.frame =
                CGRect(x: 27, y: answerBtnY, width: 320, height: 210);
        })
        answerBtn1.enabled = false
        answerBtn2.enabled = false
        answerBtn3.enabled = false
        answerBtn4.enabled = false
        
    }
    
    // 戻るボタンで次のクイズへ
    func backBtnTapped() {
        let screenHeight = Double(UIScreen.mainScreen().bounds.size.height)
        UIView.animateWithDuration(0.5, animations: {() ->
            Void in self.kaisetsuBGImageView.frame =
                CGRect(x: 27, y: screenHeight, width: 320, height: 210)
        })
        
        answerBtn1.enabled = true
        answerBtn2.enabled = true
        answerBtn3.enabled = true
        answerBtn4.enabled = true

        judgeImageView.hidden = true
        nextQuiz()
    }

    // クイズのシャッフル
    func quizShuffle() -> [String] {
        var array = [String]()
        let sortedArray = NSMutableArray(array: csvArray)
        var arrayCount = sortedArray.count
        while(arrayCount > 0) {
            let randomIndex = arc4random() % UInt32(arrayCount)
            sortedArray.exchangeObjectAtIndex((arrayCount-1),
                withObjectAtIndex: Int(randomIndex))
            arrayCount = arrayCount-1
            array.append(sortedArray[arrayCount] as! String)
        }
        return array
    }

    // ScoreViewControllerへの正解数引き渡し
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sVC = segue.destinationViewController as! ScoreViewController
        sVC.correct = correctCount
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
