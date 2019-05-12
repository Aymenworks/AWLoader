//
//  AWGradientLoader.swift
//  AWLoader
//
//  Created by Rebouh Aymen on 11/05/2019.
//  Copyright © 2019 Rebouh Aymen. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public class AWGradientLoader: UIView {
    
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
        shapeContainerView.layer.removeAnimation(forKey: "rotation")
    }
    
    // MARK: Customization - How to customize this component in the init method
    
    private let shape: AWLoaderShape
    private let gradientColors: [UIColor]
    private let gradientLocations: [NSNumber]
    private let containerBackgroundColor: UIColor
    private let animationDuration: CFTimeInterval
    private let blurStyle: UIBlurEffect.Style?
    private let borderWidth: CGFloat

    // MARK: Private
    
    private weak var presentingView: UIView?
    private var visualEffectView: UIVisualEffectView?
    private let containerView = UIView()
    private let shapeContainerView = UIView()
    private let gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle
    
    public init(showInView presentingView: UIView,
                animationDuration: CFTimeInterval = 1.5,
                blurStyle: UIBlurEffect.Style? = nil,
                shape: AWLoaderShape = .circle,
                containerBackgroundColor: UIColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1),
                gradientColors: [UIColor],
                gradientLocations: [NSNumber],
                borderWidth: CGFloat = 1
        )  {
        
        self.animationDuration = animationDuration
        self.blurStyle = blurStyle
        self.shape = shape
        self.containerBackgroundColor = containerBackgroundColor
        self.gradientColors = gradientColors
        self.gradientLocations = gradientLocations
        self.borderWidth = borderWidth

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
        
        containerView.backgroundColor = containerBackgroundColor
        addSubview(containerView)
        
        shapeContainerView.backgroundColor = .clear
        containerView.addSubview(shapeContainerView)

        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = gradientLocations
        shapeContainerView.layer.addSublayer(gradientLayer)

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
            break
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
        
        gradientLayer.frame = shapeContainerView.bounds
        
        let gradientShapeMask = CAShapeLayer()
        let gradientPath = circlePath
        let approximateBorderWidth: CGFloat = radius / (1 + (borderWidth/10))
        gradientPath.append(UIBezierPath(arcCenter: center,
                                 radius: approximateBorderWidth,
                                 startAngle: startAngle,
                                 endAngle: endAngle,
                                 clockwise: false))
        gradientShapeMask.fillRule = .evenOdd
        gradientShapeMask.path = gradientPath.cgPath
        gradientLayer.mask = gradientShapeMask
    }
}
