//
//  ViewController.swift
//  SwiftTableView
//
//  Created by Stevenson on 6/3/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailDelegate {
    
    //MARK: Properties
    
    @IBOutlet var theTableView: UITableView
    
    var sections: String[] = ["Part 1", "Part 2"]
    var cellTitles = Dictionary<String,Array<String>>()
    var selectedColor = UIColor()
    var currentSelected: NSIndexPath?
    
    override func viewDidLoad() {
        theTableView.delegate = self;
        theTableView.dataSource = self;
        setupListNames()
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup Methods
    func setupListNames() {
        for (index,value) in enumerate(sections) {
            var titlesInSection = Array<String>()
            for i in 0..20 {
                titlesInSection.append("Row \(i) in \(value)")
            }
            cellTitles.updateValue(titlesInSection, forKey: value)
        }
        
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
        if let destVC: DetailViewController = segue.destinationViewController as? DetailViewController {
            destVC.makeRandomBackgroundColor()
            destVC.myDelegate = self
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        currentSelected = indexPath
    }
    
    
    //MARK: DetailDelegate
    func changedName(newName: String) {
        if let selectedIndexPath = currentSelected {
            let sectionName = sections[ selectedIndexPath.section ]
            var rowNames = cellTitles["\(sectionName)"]!
            let rowIndex: Int = selectedIndexPath.row
            rowNames[ rowIndex ] = newName
            
            cellTitles["\(sectionName)"] = rowNames
            theTableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Right)
        }
        NSLog("%@", cellTitles)
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = getRandomColor()
        let sectionName = sections[indexPath.section]
        if let rowNames: Array = cellTitles["\(sectionName)"] {
            cell.textLabel.text = rowNames[ indexPath.row ]
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section:Int) ->String! {
        return sections[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView!) -> AnyObject[]! {
        return sections
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        let sectionName = sections[section]
        if let rowNames: Array = cellTitles["\(sectionName)"] {
            return rowNames.count
        } else {
            return 0
        }
    }

    

}

