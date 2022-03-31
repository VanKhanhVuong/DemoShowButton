//
//  ViewController.swift
//  DemoShowButton
//
//  Created by admin on 30/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate let centerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 1
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        return button
    }()
    
    fileprivate let radiusLabel: UILabel = {
        let label = UILabel()
        label.text = "Radius: "
        return label
    }()
    
    fileprivate let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Number button: "
        return label
    }()
    
    fileprivate let numberSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 20
        slider.minimumValue = 1
        slider.addTarget(self, action: #selector(changeNumberSlider(sender:)), for: .valueChanged)
        return slider
    }()
    
    fileprivate let radiusSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 180
        slider.minimumValue = 50
        slider.addTarget(self, action: #selector(changeRadiusSlider(sender:)), for: .valueChanged)
        return slider
    }()
    
    fileprivate let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Size button: "
        return label
    }()
    
    fileprivate let sizeBtnSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 50
        slider.minimumValue = 10
        slider.addTarget(self, action: #selector(changeSizeButtonSlider(sender:)), for: .valueChanged)
        return slider
    }()
    
    private var number: Int = 1
    private var radius: Float = 50
    private var size: Float = 10
    private let colorPrimary: UIColor = .red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        [centerButton, radiusLabel, numberLabel, numberSlider, radiusSlider, sizeLabel, sizeBtnSlider].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }

        // Set contraints
        let layoutGuide = view.safeAreaLayoutGuide
        
        centerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        centerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        radiusSlider.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -30).isActive = true
        radiusSlider.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -5).isActive = true
        radiusSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        radiusLabel.centerYAnchor.constraint(equalTo: radiusSlider.centerYAnchor, constant: 0).isActive = true
        radiusLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 5).isActive = true
        radiusLabel.trailingAnchor.constraint(equalTo: radiusSlider.leadingAnchor, constant: 0).isActive = true
        radiusLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3).isActive = true
        
        numberSlider.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -5).isActive = true
        numberSlider.bottomAnchor.constraint(equalTo: radiusSlider.topAnchor, constant: -10).isActive = true
        numberSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        numberLabel.centerYAnchor.constraint(equalTo: numberSlider.centerYAnchor, constant: 0).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 5).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: numberSlider.leadingAnchor, constant: 0).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3).isActive = true
        
        sizeBtnSlider.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -5).isActive = true
        sizeBtnSlider.bottomAnchor.constraint(equalTo: numberSlider.topAnchor, constant: -10).isActive = true
        sizeBtnSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sizeLabel.centerYAnchor.constraint(equalTo: sizeBtnSlider.centerYAnchor, constant: 0).isActive = true
        sizeLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 5).isActive = true
        sizeLabel.trailingAnchor.constraint(equalTo: sizeBtnSlider.leadingAnchor, constant: 0).isActive = true
        sizeLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3).isActive = true
    }

    private func createButton(size: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: size).isActive = true
        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        button.layer.cornerRadius = size / 2
        button.addTarget(self, action: #selector(hideButton(sender:)), for: .touchUpInside)
        return button
    }
    
    private func removeView() {
        for i in 3...23 {
            if let viewWithTag = self.view.viewWithTag(i) {
                viewWithTag.removeFromSuperview()
            }
        }
    }

    private func setUpButtons(count: Int, around center: UIView, radius: CGFloat) {
        // Tính góc mỗi button
        let degrees = 360 / CGFloat(count)

        for i in 3 ..< count + 3 {
            let button = createButton(size: CGFloat(self.size))
            button.tag = i
            self.view.addSubview(button)

            // Vẽ khoảng cách từ trung tâm hình tròn lớn đến trung tâm hình tròn nhỏ n
            let hOffset = radius * cos(CGFloat(i) * degrees * .pi / 180)
            let vOffset = radius * sin(CGFloat(i) * degrees * .pi / 180)

            // Set trung tâm của button N so với button lớn
            button.centerXAnchor.constraint(equalTo: center.centerXAnchor, constant: hOffset).isActive = true
            button.centerYAnchor.constraint(equalTo: center.centerYAnchor, constant: vOffset).isActive = true
        }
    }
    
    private func paintingButton() {
        removeView()
        setUpButtons(count: self.number, around: centerButton, radius: CGFloat(self.radius))
    }
    
    @objc func hideButton(sender: UIButton) {
        print("Click button i[\(sender.tag)]")
        if sender.backgroundColor == colorPrimary {
            sender.backgroundColor = .white
            sender.layer.borderWidth = 0.5
        } else {
            sender.backgroundColor = colorPrimary
            sender.layer.borderWidth = 0
        }
    }
    
    @objc func changeNumberSlider(sender: UISlider) {
        self.number = Int(sender.value)
        paintingButton()
    }
    
    @objc func changeRadiusSlider(sender: UISlider) {
        self.radius = Float(sender.value)
        paintingButton()
    }
    
    @objc func changeSizeButtonSlider(sender: UISlider) {
        self.size = Float(sender.value)
        paintingButton()
    }
}
