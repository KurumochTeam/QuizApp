//
//  SplitButton.swift
//  QuizApp
//
//  Created by Денис on 12.10.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

class SplitButton: UIView, NibOwnerLoadable {
    @IBOutlet private var leftView: UIView!
    @IBOutlet private var rightView: UIView!
    @IBOutlet private var leftImageView: UIImageView!
    @IBOutlet private var rightImageView: UIImageView!

    @IBOutlet private var menuButton: MenuButton!

    private var didTapLeftButton: (() -> Void)?
    private var didTapRightButton: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateRoundedViews()
    }

    struct Handlers {
        let didTapLeftButton: () -> Void
        let didTapRightButton: () -> Void
    }

    func cofigure(text: String, mainImage: UIImage?, leftImage: UIImage, rightImage: UIImage, handlers: Handlers) {
        menuButton.configure(title: text, image: mainImage, tapAction: animateTransition)
        leftImageView.image = leftImage
        rightImageView.image = rightImage
        didTapLeftButton = handlers.didTapLeftButton
        didTapRightButton = handlers.didTapRightButton
    }
}

private extension SplitButton {
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
            path.move(to: CGPoint(x: width - radius, y: 0))

            path.addQuadCurve(
                to: CGPoint(x: width, y: radius), // правый верхний угол
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
            path.addCurve( // снизу посередине
                to: CGPoint(x: radius, y: height), //
                controlPoint1: CGPoint(x: hCenter - offset, y: shouldCollapseCenter ? vCenter : height),
                controlPoint2: CGPoint(x: hCenter - offset, y: height)
            )
            path.addQuadCurve(
                to: CGPoint(x: 0, y: height - radius), // левый нижний угол
                controlPoint: CGPoint(x: 0, y: height) //
            )
            path.addLine(to: CGPoint(x: 0, y: radius))

            path.addQuadCurve(
                to: CGPoint(x: radius, y: 0), //
                controlPoint: CGPoint(x: 0, y: 0) // левый верхний угол
            )
            path.addCurve(
                to: CGPoint(x: hCenter, y: shouldCollapseCenter ? vCenter : 0),
                controlPoint1: CGPoint(x: hCenter - offset, y: 0),
                controlPoint2: CGPoint(x: hCenter - offset, y: shouldCollapseCenter ? vCenter : 0)
            )
            path.addCurve( // сверху посередине
                to: CGPoint(x: width - radius, y: 0), //
                controlPoint1: CGPoint(x: hCenter + offset, y: shouldCollapseCenter ? vCenter : 0),
                controlPoint2: CGPoint(x: hCenter + offset, y: 0)
            )
            return path
        }

        func makePath(isFinal: Bool, isLeft: Bool) -> UIBezierPath {
            let path = UIBezierPath()
            let offset = isFinal ? CGFloat(25) : 0
            let side = isLeft ? 0 : width

            let sideX = abs(side - offset)
            let radX = abs(side - endRadius - offset)
            let rad2X = abs(side - endRadius * 2 - offset)
            let midX = (hCenter + radX) / 2

            path.move(to: CGPoint(x: radX, y: 0))
            if isFinal {
                path.addQuadCurve(
                    to: CGPoint(x: rad2X, y: vCenter),
                    controlPoint: CGPoint(x: rad2X, y: 0)
                )
                path.addQuadCurve(
                    to: CGPoint(x: radX, y: height),
                    controlPoint: CGPoint(x: rad2X, y: height)
                )
            } else {
                path.addCurve(
                    to: CGPoint(x: hCenter, y: vCenter),
                    controlPoint1: CGPoint(x: midX, y: 0),
                    controlPoint2: CGPoint(x: midX, y: vCenter)
                )
                path.addCurve(
                    to: CGPoint(x: radX, y: height),
                    controlPoint1: CGPoint(x: midX, y: vCenter),
                    controlPoint2: CGPoint(x: midX, y: height)
                )
            }
            path.addQuadCurve(
                to: CGPoint(x: sideX, y: vCenter),
                controlPoint: CGPoint(x: sideX, y: height)
            )
            path.addQuadCurve(
                to: CGPoint(x: radX, y: 0),
                controlPoint: CGPoint(x: sideX, y: 0)
            )

            return path
        }

        let startPath = makeFullPath(radius: startRadius, shouldCollapseCenter: false)
        let endPath = makeFullPath(radius: endRadius, shouldCollapseCenter: true)

        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = 0.1

        let shapeLayer = CAShapeLayer(layer: menuButton.layer)
        shapeLayer.fillColor = #colorLiteral(red: 0.3647058824, green: 0.2784313725, blue: 0.9607843137, alpha: 1)

        menuButton.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        menuButton.layer.addSublayer(shapeLayer)

        let leftLayer = CAShapeLayer()
        leftLayer.fillColor = #colorLiteral(red: 0.3647058824, green: 0.2784313725, blue: 0.9607843137, alpha: 1)
        menuButton.layer.addSublayer(leftLayer)

        let leftPathStart = makePath(isFinal: false, isLeft: true)
        let leftPathEnd = makePath(isFinal: true, isLeft: true)

        leftLayer.path = leftPathStart.cgPath

        let leftAnimation = CASpringAnimation(keyPath: "path")
        leftAnimation.fromValue = leftPathStart.cgPath
        leftAnimation.toValue = leftPathEnd.cgPath
        leftAnimation.duration = leftAnimation.settlingDuration

        let rightLayer = CAShapeLayer()
        rightLayer.fillColor = #colorLiteral(red: 0.3647058824, green: 0.2784313725, blue: 0.9607843137, alpha: 1)
        menuButton.layer.addSublayer(rightLayer)

        let rightPathStart = makePath(isFinal: false, isLeft: false)
        let rightPathEnd = makePath(isFinal: true, isLeft: false)

        rightLayer.path = rightPathStart.cgPath

        let rightAnimation = CASpringAnimation(keyPath: "path")
        rightAnimation.fromValue = rightPathStart.cgPath
        rightAnimation.toValue = rightPathEnd.cgPath
        rightAnimation.duration = rightAnimation.settlingDuration

        UIView.animate(withDuration: 0.1, animations: {
            self.menuButton.setAlphaOfSubviews(0)
        }) { _ in
            shapeLayer.add(animation, forKey: "anim")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                rightLayer.add(rightAnimation, forKey: "right")
                leftLayer.add(leftAnimation, forKey: "left")
            }
        }
    }

    func updateRoundedViews() {
        [rightView, leftView].forEach {
            $0?.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.2784313725, blue: 0.9607843137, alpha: 1)
            $0!.layer.cornerRadius = $0!.frame.height
        }
    }
}
