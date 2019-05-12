//
//  AWLoader.swift
//  TestLoader
//
//  Created by Rebouh Aymen on 21/02/2016.
//  Copyright © 2016 Aymen Rebouh. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public enum AWLoaderShape {
    case rounded(CGFloat), circle, none
}

public class AWLoader: UIView {
    
    // MARK: Developer Experience - How to use this AWLoader component
    
    public private(set) var isAnimating: Bool = false
    
    /// WIll only display the loader if the `set(inView presentingView: UIView)` has been called earlier
    public func show() {
        isHidden = false
        isAnimating = true
        
        let infiniteRotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        infiniteRotateAnimation.repeatCount = .greatestFiniteMagnitude
        infiniteRotateAnimation.fromValue = 0
        infiniteRotateAnimation.toValue = CGFloat.pi * 2
        infiniteRotateAnimation.duration = animationDuration
        
        shapeContainerView.layer.add(infiniteRotateAnimation, forKey: "rotation")
    }
    
    public func hide() {
        isAnimating = false
        isHidden = true
        circleLayer.removeAnimation(forKey: "rotation")
    }
    
    // MARK: Customization - How to customize this component in the init method
    
    private let lineWidth: CGFloat
    private let shape: AWLoaderShape
    private let lineColor: UIColor
    private let containerBackgroundColor: UIColor
    private let animationDuration: CFTimeInterval
    private let blurStyle: UIBlurEffect.Style?
    
    // MARK: Private

    private weak var presentingView: UIView?
    private var visualEffectView: UIVisualEffectView?
    private let containerView = UIView()
    private let shapeContainerView = UIView()
    private let circleLayer = CAShapeLayer()
    
    // MARK: - Lifecycle
    
    public init(showInView presentingView: UIView,
                animationDuration: CFTimeInterval = 1.5,
                blurStyle: UIBlurEffect.Style? = .light,
                shape: AWLoaderShape = .rounded(6),
                containerBackgroundColor: UIColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1),
                lineWidth: CGFloat = 2,
                lineColor: UIColor = .black
                )  {
        
        self.animationDuration = animationDuration
        self.blurStyle = blurStyle
        self.lineWidth = lineWidth
        self.shape = shape
        self.lineColor = lineColor
        self.containerBackgroundColor = containerBackgroundColor

        super.init(frame: .zero)
        
        self.isHidden = true
        self.presentingView = presentingView
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class cannot be loaded from this init")
    }
    
    // MARK: Setup
    
    private func setup() {
        
        guard let presentingView = self.presentingView else { return }
        
        presentingView.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: presentingView.topAnchor),
            self.bottomAnchor.constraint(equalTo: presentingView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: presentingView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: presentingView.trailingAnchor)
        ])
        
        // Same corner radius as the presenting view
        layer.cornerRadius = presentingView.layer.cornerRadius
        clipsToBounds = true

        if let blurStyle = blurStyle {
            visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
            addSubview(visualEffectView!)
        }
        
        switch shape {
        case .circle, .rounded(_):
            containerView.backgroundColor = containerBackgroundColor
        case .none:
            containerView.backgroundColor = .clear
        }
        
        addSubview(containerView)
        
        shapeContainerView.backgroundColor = .clear
        containerView.addSubview(shapeContainerView)
        
        circleLayer.fillColor   = nil
        circleLayer.strokeColor = self.lineColor.cgColor
        circleLayer.lineWidth = self.lineWidth
        circleLayer.strokeStart = 0.0
        circleLayer.strokeEnd   = 0.87
        
        shapeContainerView.layer.addSublayer(circleLayer)
        
        layout: do  {
            if let visualEffectView = visualEffectView {
                visualEffectView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    visualEffectView.topAnchor.constraint(equalTo: self.topAnchor),
                    visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])
            }
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
                containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
            ])
            
            shapeContainerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                shapeContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                shapeContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                shapeContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                shapeContainerView.heightAnchor.constraint(equalTo: shapeContainerView.widthAnchor)
            ])
        }
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        switch shape {
        case .circle:
            containerView.layer.cornerRadius = containerView.layer.bounds.height/2.0
        case .rounded(let cornerRadius):
            containerView.layer.cornerRadius = cornerRadius
        case .none:
            containerView.backgroundColor = .clear
        }
        
        let center: CGPoint = .init(x: shapeContainerView.bounds.width/2, y: shapeContainerView.bounds.height/2)
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = .pi * 2
        let radius: CGFloat = shapeContainerView.bounds.width  / 2
        
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: false)
        
        circleLayer.frame = shapeContainerView.bounds
        circleLayer.path = circlePath.cgPath
    }
}
