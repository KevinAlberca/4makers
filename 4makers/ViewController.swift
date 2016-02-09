//
//  ViewController.swift
//  4makers
//
//  Created by Kevin Alberca on 05/01/16.
//  Copyright © 2016 AwH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var videos = [Videos]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let videoJson = self.getJSON(Api.getVideoUrlString);
        do {

            let result = try NSJSONSerialization.JSONObjectWithData(videoJson,
            options: []) as! NSArray
            print(result)

            for video in result {
               let newVideo = Videos(creator_name: video["creator_name"] as! String, identifier: video["id"] as! Int, link: video["link"] as! String)
                self.videos.append(newVideo)
            }
            
        } catch  {
            print("error trying to convert data to JSON")
            return
        }



    
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("user") == nil {
 //           performSegueWithIdentifier("connectionSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("videoCell") as! videoCell
        let row = indexPath.row

        cell.userName.text = self.videos[row].creator_name
        cell.centerImageView.image = UIImage(named: "nature")
        cell.centerImageView.layer.masksToBounds = true
        return cell
    }
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }

}
