//
//  HamburgerViewController.swift
//  YouTube
//
//  Created by Marc Haumann on 2/24/16.
//  Copyright © 2016 Marc Haumann. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    var initialX: CGFloat! = 0
    
    var menuViewCont: UIViewController!
    var feedViewCont: UIViewController!
    var transform3d = CATransform3DIdentity

    override func viewDidLoad() {
        super.viewDidLoad()
        transform3d.m34 = 1.0 / 500.0
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vcMenu = storyboard.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
        var vcFeed = storyboard.instantiateViewControllerWithIdentifier("Feed") as! FeedViewController
        menuView.addSubview(vcMenu.view)
        feedView.addSubview(vcFeed.view)
        menuView.transform = CGAffineTransformMakeScale(0.9,0.9)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func feedViewDidPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
         if (sender.state == UIGestureRecognizerState.Began) {
            self.feedView.frame.origin.x = initialX
        }  else if (sender.state == UIGestureRecognizerState.Changed) {
            self.feedView.frame.origin.x = initialX + translation.x
            let scaleVal = convertValue(self.feedView.frame.origin.x, r1Min: 0, r1Max: 270, r2Min: 0.9, r2Max: 1)
            self.menuView.transform = CGAffineTransformMakeScale(scaleVal, scaleVal)
//            self.menuView.transform = CATransform3DRotate(transform3d, CGFloat(45 * M_PI / 180), 0, 1, 0)
//            print("changed \(self.feedView.frame.origin.x)")
            
        }  else if (sender.state == UIGestureRecognizerState.Ended) {
//            print("ended \(self.feedView.frame.origin.x)")
            if self.feedView.frame.origin.x < 160 {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [], animations: { () -> Void in
                    self.feedView.frame.origin.x = 0
                    self.initialX = 0
                    }, completion: nil)
            }
            else {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [], animations: { () -> Void in
                    self.feedView.frame.origin.x = 270
                    self.initialX = 270
                    }, completion: nil)
            }
        }
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
