//
//  DetailViewController.swift
//  SwiftTableView
//
//  Created by Stevenson on 6/3/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

import UIKit

protocol DetailDelegate {
    func changedName(newName: String)
    
}

class DetailViewController: UIViewController {
    
    var myDelegate: DetailDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRandomBackgroundColor()
        // Do any additional setup after loading the view.
    }
    
    func makeRandomBackgroundColor() {
        self.view.backgroundColor = {
            var array: CGFloat[] = Array()
            for i in 0..3 {
                let r: UInt32 = arc4random_uniform(256)
                let component: CGFloat = CGFloat(r) / 256.0
                array.append( component )
            }
            return UIColor(red: array[0], green: array[1], blue: array[2], alpha: 1)
        }()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton() {
        dismissViewControllerAnimated(true, completion: nil)
        if let delegate = myDelegate {
            delegate.changedName("Name Changed!")
        }
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
