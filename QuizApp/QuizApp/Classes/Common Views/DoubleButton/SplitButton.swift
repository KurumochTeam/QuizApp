//
//  SplitButton.swift
//  QuizApp
//
//  Created by Денис on 12.10.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

class SplitButton: UIView, NibOwnerLoadable {
    @IBOutlet private var leftButton: UIButton!
    @IBOutlet private var rightButton: UIButton!
    @IBOutlet private var leftButtonContainer: UIView!
    @IBOutlet private var rightButtonContainer: UIView!
    
    @IBOutlet private var menuButton: MenuButton!
    
    private var leftButtonShadowLayer: CALayer!
    private var rightButtonShadowLayer: CALayer!

    private var didTapLeftButton: (() -> ())?
    private var didTapRightButton: (() -> ())?

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
        let didTapMainButton: () -> ()
        let didTapLeftButton: () -> ()
        let didTapRightButton: () -> ()
    }

    func cofigure(
        text: String,
        mainImage: UIImage?,
        leftImage: UIImage,
        rightImage: UIImage,
        handlers: Handlers
    ) {
        menuButton.configure(title: text, image: mainImage, tapAction: handlers.didTapMainButton)
        leftButton.setImage(leftImage, for: .normal)
        rightButton.setImage(rightImage, for: .normal)
        didTapLeftButton = handlers.didTapLeftButton
        didTapRightButton = handlers.didTapRightButton
    }
}

private extension SplitButton {
    // TODO: Refactor - merge with constants from MenuButton
    enum LayerConstants {
        static let relativeWidth = CGFloat(0.83)
    }
    
    @IBAction func didTapLeftButton(_ sender: Any) {
        didTapLeftButton?()
    }

    @IBAction func didTapRightButton(_ sender: Any) {
        didTapRightButton?()
    }

    func updateRoundedViews() {
        [leftButtonContainer, rightButtonContainer].forEach {
            $0?.layer.cornerRadius = layer.frame.height * LayerConstants.relativeWidth / 2
        }
    }
}

extension SplitButton {
    enum AnimationScaleConstants {
        static let imageMinScale = CGFloat(0)
        static let imageNormalScale = CGFloat(1)
        static let imageMaxScale = CGFloat(1.2)
    }
    
    enum AnimationDurationConstants {
        static let frameResizeDuration = TimeInterval(0.15)
        static let imageScaleToMaxDuration = TimeInterval(0.15)
        static let imageScaleToNormalDuration = TimeInterval(0.2)
    }
    
    func showAdditionalButtons() {
        showButtonsAnimated()
    }
    
    private func showButtonsAnimated() {
        let buttonsResizeAnimator = createResizeAnimator()
        
        let leftButtonImageFirstStepAnimator = createAnimator(
            forButton: leftButton,
            transformScale: AnimationScaleConstants.imageMaxScale,
            duration: AnimationDurationConstants.imageScaleToMaxDuration
        )
        
        let leftButtonImageSecondStepAnimator = createAnimator(
            forButton: leftButton,
            transformScale: AnimationScaleConstants.imageNormalScale,
            duration: AnimationDurationConstants.imageScaleToNormalDuration
        )
        
        let rightButtonImageFirstStepAnimator = createAnimator(
            forButton: rightButton,
            transformScale: AnimationScaleConstants.imageMaxScale,
            duration: AnimationDurationConstants.imageScaleToMaxDuration
        )
        
        let rightButtonImageSecondStepAnimator = createAnimator(
            forButton: rightButton,
            transformScale: AnimationScaleConstants.imageNormalScale,
            duration: AnimationDurationConstants.imageScaleToNormalDuration
        )
        
        buttonsResizeAnimator
            .thenStart(leftButtonImageFirstStepAnimator)
            .thenStart(leftButtonImageSecondStepAnimator)
            .thenStart(rightButtonImageFirstStepAnimator)
            .thenStart(rightButtonImageSecondStepAnimator)
        
        buttonsResizeAnimator.startAnimation()
    }
    
    private func createResizeAnimator() -> UIViewPropertyAnimator {
        let startLeftFrame = leftButtonContainer.frame
        let startRightFrame = rightButtonContainer.frame
        
        leftButtonContainer.frame = CGRect(
            x: menuButton.frame.origin.x,
            y: menuButton.frame.origin.y,
            width: menuButton.frame.width / 2,
            height: menuButton.frame.height
        )
        
        rightButtonContainer.frame = CGRect(
            x: menuButton.frame.width / 2,
            y: menuButton.frame.origin.y,
            width: menuButton.frame.width / 2,
            height: menuButton.frame.height
        )
        
        leftButton.imageView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        rightButton.imageView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        leftButtonContainer.isHidden = false
        rightButtonContainer.isHidden = false
        menuButton.isHidden = true
        
        return UIViewPropertyAnimator(
            duration: AnimationDurationConstants.frameResizeDuration,
            curve: .easeOut
        ) { [weak self] in
            self?.leftButtonContainer.frame = startLeftFrame
            self?.rightButtonContainer.frame = startRightFrame
        }
    }
    
    private func createAnimator(
        forButton button: UIButton,
        transformScale scale: CGFloat,
        duration: TimeInterval
    ) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(
            duration: duration, curve: .easeOut
        ) { button.imageView?.transform = CGAffineTransform(scaleX: scale, y: scale) }
    }
    
    func showMainButton() {
        
    }
}

private extension UIViewPropertyAnimator {
    @discardableResult
    func thenStart(_ animator: UIViewPropertyAnimator) -> UIViewPropertyAnimator {
        addCompletion { _ in
            animator.startAnimation()
        }
        
        return animator
    }
}
