//
//  ViewController.swift
//  FunnyLab
//
//  Created by Vu Nguyen on 7/28/16.
//  Copyright © 2016 VuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var trayOriginalCenter = CGPoint()
    var trayCenterClose = CGPoint()
    var trayCenterOpen = CGPoint()
    var imageOriginalCenter = CGPoint()
     var panGestureVelocity: CGPoint!
    
    var newCreateFace = UIImageView()
    
    @IBOutlet var trayView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayCenterClose = CGPoint(x: 160.0, y: 607.0)
        trayCenterOpen = CGPoint(x: 160.0, y: 488.0)
        //print("\(trayView.center)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        //let point = panGestureRecognizer.locationInView(view)
        var translation: CGPoint!
        
        
       
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
            //print("Gesture began at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            translation = panGestureRecognizer.translationInView(view)
            panGestureVelocity = panGestureRecognizer.velocityInView(view)
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
          
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            
            if panGestureVelocity.y > 0{
                
                
                trayView.center = trayCenterClose
            } else if panGestureVelocity.y < 0 {
                UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
                    self.trayView.center = self.trayCenterOpen
                    }, completion: nil)
                
            }
            //print("Gesture ended at: \(point)")
        }
        
    }
    
    @IBAction func onTrayTap(tapTrayRecognizer: UITapGestureRecognizer) {
        
        if trayView.center == trayCenterOpen {
            trayView.center = trayCenterClose
        } else if trayView.center == trayCenterClose {
            trayView.center = trayCenterOpen
            
        }
        
    }
    
    @IBAction func onImagePanGesture(imagePanGestureRecognizer: UIPanGestureRecognizer) {
        
        var translation: CGPoint!
        let imageView = imagePanGestureRecognizer.view as! UIImageView
        let offsetPoint = trayView.frame.origin
        
        
        
        
        if imagePanGestureRecognizer.state == UIGestureRecognizerState.Began {
            newCreateFace = UIImageView(image: imageView.image)
            view.addSubview(newCreateFace)
            newCreateFace.userInteractionEnabled = true
            
            let PanGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.onPanImage(_:)))
            
            let PinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.onPinchImage(_:)))
            
            newCreateFace.addGestureRecognizer(PanGesture)
            newCreateFace.addGestureRecognizer(PinchGesture)
            
            newCreateFace.center = imageView.center
            newCreateFace.center.y += offsetPoint.y
            newCreateFace.transform = CGAffineTransformMakeScale(2, 2)
            imageOriginalCenter = newCreateFace.center
            
        } else if imagePanGestureRecognizer.state == UIGestureRecognizerState.Changed {
            translation = imagePanGestureRecognizer.translationInView(view)
            //panGestureVelocity = imagePanGestureRecognizer.velocityInView(view)
            newCreateFace.center = CGPoint(x: imageOriginalCenter.x + translation.x, y: imageOriginalCenter.y + translation.y)
            
        } else if imagePanGestureRecognizer.state == UIGestureRecognizerState.Ended {
            //newCreateFace.transform = CGAffineTransformMakeScale(0.5, 0.5)
        }
        
    }
    
    
    func onPanImage(gesture: UIPanGestureRecognizer){
        var translation: CGPoint!
        translation = gesture.translationInView(view)
        //print(gesture.locationInView(view))
        let currentImage = gesture.view as! UIImageView
        if gesture.state == UIGestureRecognizerState.Began {
            imageOriginalCenter = currentImage.center
            
        } else if gesture.state == UIGestureRecognizerState.Changed {
            translation = gesture.translationInView(view)
            //panGestureVelocity = imagePanGestureRecognizer.velocityInView(view)
            currentImage.center = CGPoint(x: imageOriginalCenter.x + translation.x, y: imageOriginalCenter.y + translation.y)
            
        } else if gesture.state == UIGestureRecognizerState.Ended {
            
            
            
        }
        
    }
    
    func onPinchImage(pinchGesture: UIPinchGestureRecognizer) {
        
        var originalTransform = CGAffineTransform()
        let currentImage = pinchGesture.view
        currentImage?.transform = CGAffineTransformScale(originalTransform, pinchGesture.scale, pinchGesture.scale)
        pinchGesture.scale = 1
        
//        if pinchGesture.state == UIGestureRecognizerState.Began {
//            originalTransform = view.transform
//            
//        } else if pinchGesture.state == UIGestureRecognizerState.Changed {
//            currentImage?.transform = CGAffineTransformScale(originalTransform, pinchGesture.scale, pinchGesture.scale)
//        } else if pinchGesture.state == UIGestureRecognizerState.Ended {
//            
//        }
        
        
        
    }
    
    

}

