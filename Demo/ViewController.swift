//
//  ViewController.swift
//  Demo
//
//  Created by Rebouh Aymen on 08/05/2019.
//  Copyright © 2019 Rebouh Aymen. All rights reserved.
//

import UIKit
import AWLoader

class ViewController: UIViewController {

    // MARK: Properties
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let loadersConfiguration: [(title: String, loaders: [(demoViewBackgroundColor: UIColor, blurStyle:  UIBlurEffect.Style?, shape: AWLoaderShape, containerBackgroundColor: UIColor, lineWidth: CGFloat, strokeColor: UIColor )])] = [
        (title: "Container Shapes: round, circle, none",
            [
                (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .lightGray, lineWidth: 2, strokeColor: .white),
                (demoViewBackgroundColor: .white, blurStyle: nil, shape: .circle, containerBackgroundColor: .lightGray, lineWidth: 2, strokeColor: .white),
                (demoViewBackgroundColor: .white, blurStyle: nil, shape: .none, containerBackgroundColor: .clear, lineWidth: 2, strokeColor: .lightGray)
            ]
        ),
        (title: "Blur effect: light, extraLight dark, none..",
         [
            (demoViewBackgroundColor: #colorLiteral(red: 0.9254901961, green: 0.7294117647, blue: 0.2745098039, alpha: 1), blurStyle: .light, shape: .rounded(6), containerBackgroundColor: .white, lineWidth: 2, strokeColor: .lightGray),
            (demoViewBackgroundColor: #colorLiteral(red: 0.9254901961, green: 0.7294117647, blue: 0.2745098039, alpha: 1), blurStyle: .extraLight, shape: .rounded(6), containerBackgroundColor: .white, lineWidth: 2, strokeColor: .lightGray),
            (demoViewBackgroundColor: #colorLiteral(red: 0.9254901961, green: 0.7294117647, blue: 0.2745098039, alpha: 1), blurStyle: .dark, shape: .rounded(6), containerBackgroundColor: .white, lineWidth: 2, strokeColor: .lightGray),
            (demoViewBackgroundColor: #colorLiteral(red: 0.9254901961, green: 0.7294117647, blue: 0.2745098039, alpha: 1), blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .white, lineWidth: 2, strokeColor: .lightGray)
            ]
        ),
        (title: "Container backgroundColor and stroke color: pink, red, orange, any",
         [
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: #colorLiteral(red: 0.9294117647, green: 0.5215686275, blue: 0.568627451, alpha: 1), lineWidth: 2, strokeColor: #colorLiteral(red: 0.968627451, green: 0.8274509804, blue: 0.6666666667, alpha: 1)),
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .red, lineWidth: 2, strokeColor: .white),
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .orange, lineWidth: 2, strokeColor: .black),
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .black, lineWidth: 2, strokeColor: .lightGray)
            ]
        ),
        (title: "Stroke width",
         [
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .clear, lineWidth: 1, strokeColor: .gray),
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .clear, lineWidth: 3, strokeColor: .gray),
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .clear, lineWidth: 5, strokeColor: .gray),
            (demoViewBackgroundColor: .white, blurStyle: nil, shape: .rounded(6), containerBackgroundColor: .clear, lineWidth: 10, strokeColor: .gray)
            ]
        )
    ]
    
    let gradientLoadersConfiguration: [(title: String, loaders: [(demoViewBackgroundColor: UIColor, blurStyle:  UIBlurEffect.Style?, shape: AWLoaderShape, containerBackgroundColor: UIColor, gradientColors: [UIColor], gradientLocations: [NSNumber])])] = [
        (title: "Gradient loaders",
         [
            (demoViewBackgroundColor: .white, blurStyle: .dark, shape: .rounded(6), containerBackgroundColor: .clear, gradientColors: [#colorLiteral(red: 0.9294117647, green: 0.5215686275, blue: 0.568627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8274509804, blue: 0.6666666667, alpha: 1), #colorLiteral(red: 0.9294117647, green: 0.5215686275, blue: 0.568627451, alpha: 1)], gradientLocations: [0.2, 0.5, 1]),
            (demoViewBackgroundColor: .white, blurStyle: .light, shape: .rounded(6), containerBackgroundColor: .white, gradientColors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], gradientLocations: [0, 1]),
            (demoViewBackgroundColor: .gray, blurStyle: .extraLight, shape: .rounded(6), containerBackgroundColor: .white, gradientColors: [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)], gradientLocations: [0.2, 0.4, 0.6,  0.8]),
            ]
        )
    ]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            ])
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        
        let globalLoaderButton = UIButton()
        globalLoaderButton.setTitle("Loader in view", for: .normal)
        globalLoaderButton.setTitleColor(.blue, for: .normal)
        globalLoaderButton.setTitleColor(UIColor.blue.withAlphaComponent(0.6), for: .highlighted)
        globalLoaderButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        globalLoaderButton.addTarget(self, action: #selector(showGlobalLoader), for: .touchUpInside)
        
        stackView.addArrangedSubview(globalLoaderButton)
        
        for loaderConfiguration in  loadersConfiguration {
            let sectionLabel = UILabel()
            sectionLabel.numberOfLines = 0
            sectionLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
            sectionLabel.text = loaderConfiguration.title
            stackView.addArrangedSubview(sectionLabel)
            
            let horizontalStackView = UIStackView()
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 10
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                horizontalStackView.heightAnchor.constraint(equalToConstant: 180)
            ])
            
            for subConfiguration in loaderConfiguration.loaders {
                let containerView = UIView()
                containerView.backgroundColor = subConfiguration.demoViewBackgroundColor
                containerView.layer.borderColor = UIColor.lightGray.cgColor
                containerView.layer.borderWidth = 1
                containerView.layer.cornerRadius = 6
                horizontalStackView.addArrangedSubview(containerView)
                
                let loader = AWLoader(showInView: containerView,
                                      animationDuration: 1,
                                      blurStyle: subConfiguration.blurStyle,
                                      shape: subConfiguration.shape,
                                      containerBackgroundColor: subConfiguration.containerBackgroundColor,
                                      lineWidth: subConfiguration.lineWidth,
                                      strokeColor: subConfiguration.strokeColor)
                
                loader.show()
            }
            
            stackView.addArrangedSubview(horizontalStackView)
        }
        
        for gradientloaderConfiguration in  gradientLoadersConfiguration {
            let sectionLabel = UILabel()
            sectionLabel.numberOfLines = 0
            sectionLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
            sectionLabel.text = gradientloaderConfiguration.title
            stackView.addArrangedSubview(sectionLabel)

            let horizontalStackView = UIStackView()
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 10
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                horizontalStackView.heightAnchor.constraint(equalToConstant: 180)
            ])
            
            for subConfiguration in gradientloaderConfiguration.loaders {
                let containerView = UIView()
                containerView.backgroundColor = subConfiguration.demoViewBackgroundColor
                containerView.layer.borderColor = UIColor.lightGray.cgColor
                containerView.layer.borderWidth = 1
                containerView.layer.cornerRadius = 6
                horizontalStackView.addArrangedSubview(containerView)
                
                let loader = AWGradientLoader(showInView: containerView,
                                      animationDuration: 1,
                                      blurStyle: subConfiguration.blurStyle,
                                      shape: subConfiguration.shape,
                                      containerBackgroundColor: subConfiguration.containerBackgroundColor,
                                      gradientColors: subConfiguration.gradientColors,
                                      gradientLocations: subConfiguration.gradientLocations)
                
                loader.show()
            }
            
            stackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    @objc func showGlobalLoader() {
        let gradientLoader = AWGradientLoader(showInView: self.view,
                                              animationDuration: 0.7,
                                              blurStyle: .light,
                                               shape: .rounded(6),
                                               containerBackgroundColor: .white,
                                               gradientColors: [.orange, .black, .yellow],
                                               gradientLocations: [0.2, 0.5, 1],
                                               borderWidth: 4)
        gradientLoader.show()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            gradientLoader.hide()
        }
    }
}

