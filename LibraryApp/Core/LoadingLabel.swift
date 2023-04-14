//
//  LoadingLabel.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import UIKit

class LoadingLabel: UILabel {
    var timer: Timer?
    let states = ["Loading.", "Loading..", "Loading..."]

    var currentState = 0
    
    func start() {
        stop(withText: "")
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func stop(withText text: String) {
        timer?.invalidate()
        timer = nil
        self.text = text
    }
    
    @objc func update() {

        text = states[currentState]
        currentState = (currentState + 1) % states.count
    }
}
