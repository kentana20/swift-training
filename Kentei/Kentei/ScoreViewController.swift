//
//  ScoreViewController.swift
//  Kentei
//
//  Created by kensuke tanaka on 11/8/15.
//  Copyright © 2015 kentana20. All rights reserved.
//

import UIKit
import Social

class ScoreViewController: UIViewController {
    
    var correct = 0
    let okScore = 7
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var judgeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "正解数は \(correct) です！"
        if correct >= okScore {
            judgeImageView.image = UIImage(named: "images/goukaku_eru.png")!
        } else {
            judgeImageView.image = UIImage(named: "images/fugoukaku_mayaka.png")!
        }
    }

    @IBAction func postTwitter(sender: AnyObject) {
        let twVC: SLComposeViewController =
            SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twVC.setInitialText("今回の正解数は \(correct) です。")
        self.presentViewController(twVC, animated: true, completion: nil)
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
