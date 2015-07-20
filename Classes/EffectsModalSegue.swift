//
//  EffectsModalSegue.swift
//  EffectsModalSegue
//
//  Created by UGolf_Reese on 15/7/17.
//  Copyright (c) 2015年 reese. All rights reserved.
//

import UIKit




enum EffectsModalSegueType: Int {
    case Blur
    case Draken
}

enum EffectsModalSegueTransitionStyle: Int {
    case Fade = 0
    case FromTop = 1
    case FromBottom = 2
    case FromLeft = 3
    case FromRight = 4
}



class EffectsModalSegue: UIStoryboardSegue {
   
    
    var type: EffectsModalSegueType = .Draken
    var transitionStyle: EffectsModalSegueTransitionStyle = .Fade
    
    var backgroundOpacity: CGFloat = 0.4
    var backgroundBlurRadius: CGFloat = 8
    var backgroundSaturationDeltaFactor: CGFloat = 1
    var backgroundTintColor = UIColor.clearColor()
    
    
    private var backgroundImageView: UIImageView!
    private var maskView: UIView!
    private var backgroundView: UIView!
    private var contentView: UIView!
    
    override init!(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
    }
    
    
    
    
    
    override func perform() {

        let source = self.sourceViewController as! UIViewController
        let destination = self.destinationViewController as! UIViewController
        
        
        
        contentView = destination.view
        contentView.backgroundColor = UIColor.clearColor()
        contentView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        
        backgroundImageView = UIImageView(frame: destination.view.frame)
        backgroundImageView.autoresizingMask = .FlexibleHeight | .FlexibleWidth

        maskView = UIView(frame: destination.view.frame)
        maskView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        maskView.backgroundColor = UIColor.blackColor()
        maskView.alpha = 0.0
        
        backgroundView = UIView(frame: destination.view.frame)
        destination.view = backgroundView
        
        destination.view.insertSubview(backgroundImageView, atIndex: 0)
        destination.view.insertSubview(maskView, atIndex: 1)
        destination.view.addSubview(contentView)
        
        
        
        var beginFrame = destination.view.frame
        switch self.transitionStyle {
        case .FromTop:
            beginFrame.origin.y = -1 * beginFrame.size.height
        case .FromBottom :
            beginFrame.origin.y = 1 * beginFrame.size.height
        case .FromLeft :
            beginFrame.origin.x = -1 * beginFrame.size.width
        case .FromRight :
            beginFrame.origin.x = 1 * beginFrame.size.width
        default:
            beginFrame = destination.view.frame
        }
        self.contentView.frame = beginFrame
        
        
        
        let windowBounds = source.view.window!.bounds
        UIGraphicsBeginImageContextWithOptions(windowBounds.size, true, 0.0)
        source.view.window!.drawViewHierarchyInRect(windowBounds, afterScreenUpdates: true)
        var snaphost = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if self.type == .Blur {
            snaphost = snaphost.applyBlurWithRadius(backgroundBlurRadius,
                                                        tintColor: backgroundTintColor,
                                                        saturationDeltaFactor: backgroundSaturationDeltaFactor,
                                                        maskImage: nil)
        }
        backgroundImageView.image = snaphost
        
        destination.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        source.presentViewController(destination, animated: true, completion: nil)
        
        destination.transitionCoordinator()?.animateAlongsideTransition({ [weak self] (context) -> Void in
            if self!.type == .Draken {
                self!.maskView.alpha = self!.backgroundOpacity
            }

            self!.contentView.frame = self!.backgroundView.frame

        }, completion: nil)
        
        

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
