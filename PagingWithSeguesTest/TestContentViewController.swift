//
//  TestContentViewController.swift
//  PagingWithSeguesTest
//
//  Created by Arkadi Yoskovitz on 10/6/16.
//  Copyright © 2016 All4Students.info. All rights reserved.
//

import UIKit

class TestContentViewController : UIViewController {
    
    @IBOutlet weak var testContentLabel: UILabel!
    var pageNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#file) - \(#function)")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#file) - \(#function)")
        testContentLabel.text = "Page \(pageNumber)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(#file) - \(#function)")
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("\(#file) - \(#function)")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

