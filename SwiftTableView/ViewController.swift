//
//  ViewController.swift
//  SwiftTableView
//
//  Created by Stevenson on 6/3/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    @IBOutlet var theTableView: UITableView
    
    var sections: String[] = ["Part 1", "Part 2"]
    var selectedColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.theTableView.delegate = self;
        self.theTableView.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: get random color
    func getRandomColor() -> UIColor! {
        var array: CGFloat[] = Array()
        for i in 0..3 {
            let r: UInt32 = arc4random_uniform(256)
            let component: CGFloat = CGFloat(r) / 256.0
            array.append( component )
        }
        return UIColor(red: array[0], green: array[1], blue: array[2], alpha: 1)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        if segue.destinationViewController is DetailViewController {
//            segue.destinationViewController.backgroundColor = self.getRandomColor()
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "Section: \(indexPath.section) & Row: \(indexPath.row)"
        cell.backgroundColor = self.getRandomColor()
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section:Int) ->String! {
        return self.sections[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView!) -> AnyObject[]! {
        return self.sections
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 20
        } else {
            return 10
        }
    }

    

}

