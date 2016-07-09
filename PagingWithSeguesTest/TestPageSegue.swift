//
//  TestPageSegue.swift
//  PagingWithSeguesTest
//
//  Created by Arkadi Yoskovitz on 10/6/16.
//  Copyright © 2016 All4Students.info. All rights reserved.
//

import UIKit

public class TestPageSegue : UIStoryboardSegue {
    
    public override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
      
        print("\(#file) - \(#function)")
        
        guard let
            pageViewController = source as? TestPageViewController,
            destanation = destinationViewController as? TestContentViewController else { return }
        pageViewController.nextViewController = destanation
    }
    public override func perform() {
        
    }
}