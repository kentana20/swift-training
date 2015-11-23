//
//  ViewController.swift
//  Reader
//
//  Created by kensuke tanaka on 11/9/15.
//  Copyright © 2015 kentana20. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,
        UITableViewDataSource,
        UITableViewDelegate {
    @IBOutlet var table: UITableView!

    var newsDataArray = NSArray()
    var newsUrl = ""
    var publisher = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Reader"
        table.dataSource = self
        table.delegate = self
        
        // どっかのサーバにHTTPリクエストを行い、データを取得
        // まずは写経でNewsFeed
        let requestUrl = "https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"
        Alamofire.request(.GET, requestUrl).responseJSON { response in
            let jsonDic = response.result.value as! NSDictionary
            let responseData = jsonDic["responseData"] as! NSDictionary
            self.newsDataArray = responseData["results"] as! NSArray
            print("data: \(self.newsDataArray)")
            // 取得したデータをViewに表示
            self.table.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = newsDic["title"] as? String
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = newsDic["publishedDate"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        newsUrl = newsDic["unescapedUrl"] as! String
        publisher = newsDic["publisher"] as! String

        performSegueWithIdentifier("toWebView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wvc = segue.destinationViewController as! WebViewController
        wvc.newsUrl = newsUrl
        wvc.title = publisher
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

