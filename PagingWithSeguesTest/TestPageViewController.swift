//
//  TestPageViewController.swift
//  PagingWithSeguesTest
//
//  Created by Arkadi Yoskovitz on 10/6/16.
//  Copyright © 2016 All4Students.info. All rights reserved.
//

import UIKit

struct Segues {
    static let  pageSegueIdentifier = "Page"
    static let embedSegueIdentifier = "embed"
}
class TestPageViewController : UIPageViewController {
    
    let numberOfPages = 10
    var nextViewController: TestContentViewController?
    var pageIsAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#file) - \(#function)")
        
        dataSource = self
        delegate   = self
        
        let baseControllers = [createViewController(1)]
        
        setViewControllers(baseControllers, direction: .Forward, animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(#file) - \(#function)")
        
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("\(#file) - \(#function)")
        
        guard let pageNumber = sender as? Int,
            vc = segue.destinationViewController as? TestContentViewController
            where segue.identifier == Segues.pageSegueIdentifier else { return }
        
        vc.pageNumber = pageNumber
    }
    
    private func createViewController(sender: AnyObject?) -> TestContentViewController {
        print("\(#file) - \(#function)")
        
        performSegueWithIdentifier(Segues.pageSegueIdentifier, sender: sender)
        return nextViewController!
    }
    
    private func mod(x: Int,_ m: Int) -> Int{
        print("\(#file) - \(#function)")
        
        let r = x % m
        return r < 0 ? r + m : r
    }
}

extension TestPageViewController : UIPageViewControllerDelegate {
    
    // Sent when a gesture-initiated transition begins.
    @available(iOS 6.0, *)
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        print("\(#file) - \(#function)")
        
        if let testPageViewController = pageViewController as? TestPageViewController {
            testPageViewController.pageIsAnimating = true
        }
    }
    
    // Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
    @available(iOS 5.0, *)
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("\(#file) - \(#function)")
        
        if let testPageViewController = pageViewController as? TestPageViewController where finished || completed {
            testPageViewController.pageIsAnimating = false
        }
        
        if let
            containerVC = pageViewController.parentViewController       as? TestViewController,
            currentVC = pageViewController.childViewControllers.first as? TestContentViewController
            where completed
        {
            containerVC.pageControl.currentPage = currentVC.pageNumber - 1
            containerVC.pageControl.updateCurrentPageDisplay()
        }
    }
    
    // Delegate may specify a different spine location for after the interface orientation change. Only sent for transition style 'UIPageViewControllerTransitionStylePageCurl'.
    // Delegate may set new view controllers or update double-sided state within this method's implementation as well.
    @available(iOS 5.0, *)
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation
    {
        print("\(#file) - \(#function)")
        
        if let testPageViewController = pageViewController as? TestPageViewController {
            testPageViewController.pageIsAnimating = false
        }
        return UIPageViewControllerSpineLocation.Max
    }
    
    @available(iOS 7.0, *)
    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask
    {
        print("\(#file) - \(#function)")
        return UIInterfaceOrientationMask.All
    }
    @available(iOS 7.0, *)
    func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: UIPageViewController) -> UIInterfaceOrientation
    {
        print("\(#file) - \(#function)")
        return UIInterfaceOrientation.Unknown
    }
}
extension TestPageViewController : UIPageViewControllerDataSource {
    
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // Return 'nil' to indicate that no more progress can be made in the given direction.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
    @available(iOS 5.0, *)
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        print("\(#file) - \(#function)")
        
        guard let testPageViewController = pageViewController as? TestPageViewController where !testPageViewController.pageIsAnimating else {
            return nil
        }
        
        guard let testContentViewController = viewController as? TestContentViewController else {
            return nil
        }
        
        let testX = testContentViewController.pageNumber - 2
        let testM = numberOfPages
        let testModule = mod(testX,testM)
        let testModuleAdj = testModule + 1
        
        return createViewController(testModuleAdj)
    }
    
    @available(iOS 5.0, *)
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        print("\(#file) - \(#function)")
        
        guard let testPageViewController = pageViewController as? TestPageViewController where !testPageViewController.pageIsAnimating else {
            return nil
        }
        
        guard let testContentViewController = viewController as? TestContentViewController else {
            return nil
        }
        
        let testX = testContentViewController.pageNumber
        let testM = numberOfPages
        let testModule = mod(testX,testM)
        let testModuleAdj = testModule + 1
        
        return createViewController(testModuleAdj)
    }
    
    // A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
    // Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
    @available(iOS 6.0, *)
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int { // The number of items reflected in the page indicator.
        print("\(#file) - \(#function)")
        return numberOfPages
    }
    
    @available(iOS 6.0, *)
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int { // The selected item reflected in the page indicator.
        print("\(#file) - \(#function)")
        return 1
    }
}
