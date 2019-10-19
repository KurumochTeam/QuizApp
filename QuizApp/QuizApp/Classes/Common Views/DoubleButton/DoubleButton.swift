//
//  DoubleButton.swift
//  QuizApp
//
//  Created by Денис on 12.10.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

class DoubleButton: UIView, NibOwnerLoadable {
    @IBOutlet private var leftView: UIView!
    @IBOutlet private var rightView: UIView!
    @IBOutlet private var leftImageView: UIImageView!
    @IBOutlet private var rightImageView: UIImageView!
    
    @IBOutlet private var menuButton: MenuButton!
    
    var didTapLeftButton: (() -> ())?
    var didTapRightButton: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateRoundedViews()
    }
    
    struct Handlers {
        let didTapLeftButton: (() -> ())
        let didTapRightButton: (() -> ())
    }
    
    func cofigure(text: String, leftImage: UIImage, rightImage: UIImage, handlers: Handlers) {
        menuButton.configure(with: text, and: .play)
        leftImageView.image = leftImage
        rightImageView.image = rightImage
        didTapLeftButton = handlers.didTapLeftButton
        didTapRightButton = handlers.didTapRightButton
    }
}

private extension DoubleButton {
    struct TapDelegate: ButtonDelegate {
        var didTap: () -> ()
        func didButtonTap(_ button: MenuButton) {
            didTap()
        }
    }
    
    func setup() {
        
        menuButton.delegate = TapDelegate(didTap: animateTransition)
    }
    
    var inactivityTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            
        }
    }
    
    @IBAction func didTapLeftButton(_ sender: Any) {
        didTapLeftButton?()
    }
    
    @IBAction func didTapRightButton(_ sender: Any) {
        didTapRightButton?()
    }
    
    func animateTransition() {

        let width = menuButton.frame.width
        let height = menuButton.frame.height
        let hCenter = width / 2
        let vCenter = height / 2

        let startRadius = CGFloat(36)
        let endRadius = vCenter
        
        let offset = (hCenter - vCenter) / 2
        
        func makeFullPath(radius: CGFloat, shouldCollapseCenter: Bool) -> UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x:  width - radius, y: 0))
            
            path.addQuadCurve(
                to: CGPoint(x: width, y: radius),     // правый верхний угол
                controlPoint: CGPoint(x: width, y: 0) //
            )
            path.addLine(to: CGPoint(x: width, y: height - radius))
            
            path.addQuadCurve(
                to: CGPoint(x: width - radius, y: height), // правый нижний угол
                controlPoint: CGPoint(x: width, y: height) //
            )
            path.addCurve(
                to: CGPoint(x: hCenter, y: shouldCollapseCenter ? vCenter : height),
                controlPoint1: CGPoint(x: hCenter + offset, y: height),
                controlPoint2: CGPoint(x: hCenter + offset, y: shouldCollapseCenter ? vCenter : height)
            )
            path.addCurve(                                  // снизу посередине
                to: CGPoint(x: radius, y: height),          //
                controlPoint1: CGPoint(x: hCenter - offset, y: shouldCollapseCenter ? vCenter : height),
                controlPoint2: CGPoint(x: hCenter - offset, y: height)
            )
            path.addQuadCurve(
                to: CGPoint(x: 0, y: height - radius),      // левый нижний угол
                controlPoint: CGPoint(x: 0, y: height)      //
            )
            path.addLine(to: CGPoint(x: 0, y: radius))
            
            path.addQuadCurve(
                to: CGPoint(x: radius, y: 0),               //
                controlPoint: CGPoint(x: 0, y: 0)           // левый верхний угол
            )
            path.addCurve(
                to: CGPoint(x: hCenter, y: shouldCollapseCenter ? vCenter : 0),
                controlPoint1: CGPoint(x: hCenter - offset, y: 0),
                controlPoint2: CGPoint(x: hCenter - offset, y: shouldCollapseCenter ? vCenter : 0)
            )
            path.addCurve(                              // сверху посередине
                to: CGPoint(x:  width - radius, y: 0),  //
                controlPoint1: CGPoint(x: hCenter + offset, y: shouldCollapseCenter ? vCenter : 0),
                controlPoint2: CGPoint(x: hCenter + offset, y: 0)
            )
            return path
        }
        
        let startPath = makeFullPath(radius: startRadius, shouldCollapseCenter: false)
        let endPath = makeFullPath(radius: endRadius, shouldCollapseCenter: true)
        
    }
    
    func updateRoundedViews() {
        [rightView, leftView].forEach {
            $0!.layer.cornerRadius = $0!.frame.height
        }
    }
}
