//
//  OnbordingViewController.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import UIKit
import Lottie

class OnbordingViewController: UIViewController {

    // - UI 
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // - Data
    private var hideOnboarding = 0
    
    // - Lottie
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    @IBAction func nextButtonAction() {
        hideOnboarding += 1
        
        switch hideOnboarding {
        case 1:
            nextAction()
        default:
            UserDefaultsManager.shared.saveValue(value: true, data: .onboarding)
            dismiss(animated: true)
        }
    }
}

// MARK: -
// MARK: COnfigure
private extension OnbordingViewController {
    func configure() {
        configureUI()
    }
    
    func configureUI() {
        
        // Animation
        lottieAnimation.play()
        lottieAnimation.loopMode = .loop
        
        // Next button gradient
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0,
                                width: self.nextButton.frame.size.width,
                                height: self.nextButton.frame.size.height)

        self.nextButton.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func nextAction() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = 0.5
        welcomeLabel.layer.add(animation, forKey: nil)
        welcomeImage.layer.add(animation, forKey: nil)
        welcomeLabel.text = "Enjoy with my TestApp"
        welcomeImage.image = UIImage(named: "rabbit")
        nextButton.setTitle("Go", for: .normal)
    }
}
