//
//  ViewController.swift
//  CoreAnimationPractice
//
//  Created by 沈清昊 on 3/12/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var animateTextField: UITextField!
    
    
    let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))
    
    let anotherView = UIView()
    let _width: CGFloat = 200
    let _height: CGFloat = 100
    
    let squareView = UIView()
    let _sWidth: CGFloat = 40
    let _sHeight: CGFloat = 40
    
    let redCircle = UIImageView()
    let _diameter: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
        
        animation()
        anotherView.backgroundColor = .systemBlue
        view.addSubview(anotherView)
        
        squareView.backgroundColor = .systemPink
        view.addSubview(squareView)
        view.addSubview(redCircle)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        anotherView.frame = CGRect(x: view.bounds.midX - _width/2,// Move to the center dynamically
                                   y: view.bounds.midY - _height/2,
                                   width: _width,
                                   height: _height)
        squareView.frame = CGRect(x: view.bounds.midX - _sWidth/2
                                  , y: view.bounds.midY - _sHeight/2
                                  , width: _sWidth
                                  , height: _sHeight)
        redCircle.frame = CGRect(x: view.bounds.midX - _diameter/2,
                                 y: view.bounds.midY - _diameter/2
                                 , width: _diameter, height: _diameter)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: _diameter, height: _diameter))
        let img = renderer.image{ ctx in
            let rectangle = CGRect(x: 0, y: 0, width: _diameter, height: _diameter)
            
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.setLineWidth(1)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        redCircle.image = img
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
    
    @IBAction func animate(_ sender: UIButton) {
        if let command = animateTextField.text{
            switch command{
            case "scale":
                scale()
            case "rotate":
                rotate()
            case "shake":
                shake()
            case "round":
                round()
            default:
                let alertView = UIAlertController(title: "No such command.", message: "Please put a valid command", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Alright", style: .cancel, handler: nil)
                alertView.addAction(alertAction)
                present(alertView, animated: true, completion: nil)
            }
        }
        else{
            let alertView = UIAlertController(title: "No commands!", message: "Please put a command in text field.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            present(alertView, animated: true, completion: nil)
        }
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
    
    func shake(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        anotherView.layer.add(animation, forKey: "shake")
    }
    
    func round(){
        let boundingRect = CGRect(x: -_diameter/2, y: -_diameter/2, width: _diameter, height: _diameter)
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        
        orbit.duration = 2
        orbit.isAdditive = true
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        
        squareView.layer.add(orbit, forKey: "rounded")
    }
}

