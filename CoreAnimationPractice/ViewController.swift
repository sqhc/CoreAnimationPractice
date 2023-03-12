//
//  ViewController.swift
//  CoreAnimationPractice
//
//  Created by 沈清昊 on 3/12/23.
//

import UIKit

class ViewController: UIViewController {
    let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))
    
    let anotherView = UIView()
    let _width: CGFloat = 200
    let _height:CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
        
        animation()
        anotherView.backgroundColor = .systemBlue
        view.addSubview(anotherView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        anotherView.frame = CGRect(x: view.bounds.midX - _width/2,// Move to the center dynamically
                                   y: view.bounds.midY - _height/2,
                                   width: _width,
                                   height: _height)
        
        scale()
        rotate()
    }

    func animation(){
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"// To calculate the middle point of the view (x + width/2, y+ height/2)
        animation.fromValue = 20 + 140/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2) // update to the final position
    }
    
    func scale(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.4
        
        anotherView.layer.add(animation, forKey: "scale")
        anotherView.layer.transform = CATransform3DMakeScale(2, 2, 1)
    }
    
    func rotate(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z" // z-axis
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 4
        animation.duration = 1
        
        anotherView.layer.add(animation, forKey: "rotate")
        anotherView.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
    }
}

