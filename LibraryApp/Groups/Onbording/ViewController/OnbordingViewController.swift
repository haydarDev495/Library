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
    @IBOutlet weak var welcomeImage: UIImageView!
    
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // - Data
    private var hideOnboarding = 0
    
    // - Lottie
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation.play()
        lottieAnimation.loopMode = .loop
        
    }
    
    @IBAction func nextButtonAction() {
        hideOnboarding += 1
        
        switch hideOnboarding {
        case 1:
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.type = CATransitionType.push
            animation.subtype = CATransitionSubtype.fromRight
            animation.duration = 0.5
            welcomeLabel.layer.add(animation, forKey: nil)
//            infoLabel.layer.add(animation, forKey: nil)
            welcomeImage.layer.add(animation, forKey: nil)
            welcomeLabel.text = "Hello , i am Haydar and i am iOS developer"
//            infoLabel.text = "Get rid of ads and start surfing faster with ad blocker"
            welcomeImage.image = UIImage(named: "rabbit")
//            bigGreenViewWidthConstraint.constant = 6
//            smallGreenViewWidthConstraint.constant = 30
            UIView.animate(withDuration: 0.5) { [weak self] in
//                guard let sSelf = self else { return }
//                sSelf.bigGreenView.backgroundColor = UIColor(red: 0.529, green: 0.953, blue: 0.604, alpha: 0.31)
//                sSelf.smallGreenView.backgroundColor = UIColor(red: 0.529, green: 0.953, blue: 0.604, alpha: 1)
//                sSelf.view.layoutIfNeeded()
            }
            break
        case 2:
            break
        default:
            UserDefaultsManager.shared.saveValue(value: true, data: .onboarding)
            dismiss(animated: true)
        }
    }
}
