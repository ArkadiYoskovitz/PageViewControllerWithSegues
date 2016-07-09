//
//  TestViewController.swift
//  PagingWithSeguesTest
//
//  Created by Arkadi Yoskovitz on 10/6/16.
//  Copyright © 2016 All4Students.info. All rights reserved.
//

import UIKit

class TestViewController : UIViewController {
    
    @IBOutlet weak var pageLabel    : UILabel!
    @IBOutlet weak var pageControl  : UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("\(#file) - \(#function)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("\(#file) - \(#function)")
        
        guard let destanation = segue.destinationViewController as? TestPageViewController
            where segue.identifier == Segues.embedSegueIdentifier else { return }
        
        pageControl.numberOfPages = destanation.numberOfPages
        
        if let currentVC = destanation.childViewControllers.first as? TestContentViewController {
            pageControl.currentPage = currentVC.pageNumber
        } else  {
            pageControl.currentPage = 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        print("\(#file) - \(#function)")
    }
}

