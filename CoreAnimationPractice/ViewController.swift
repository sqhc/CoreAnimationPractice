//
//  ViewController.swift
//  CoreAnimationPractice
//
//  Created by 沈清昊 on 3/12/23.
//

import UIKit

class ViewController: UIViewController {
    let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
        
        animation()
    }

    func animation(){
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 20 + 140/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2) // update to the final position
    }
}

