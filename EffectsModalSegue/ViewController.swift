//
//  ViewController.swift
//  EffectsModalSegue
//
//  Created by UGolf_Reese on 15/7/17.
//  Copyright (c) 2015年 reese. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let effectsSegue = segue as! EffectsModalSegue
        effectsSegue.transitionStyle = .FromTop
        effectsSegue.transitionStyle = .FromBottom
//        effectsSegue.transitionStyle = .FromLeft
//        effectsSegue.transitionStyle = .FromRight
        effectsSegue.type = .Blur
        effectsSegue.type = .Draken

    }
    
    @IBAction func unWindToFirstViewController(segue: UIStoryboardSegue) { }

}

