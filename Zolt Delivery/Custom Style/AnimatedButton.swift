//
//  AnimatedButton.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 10.03.25.
//

import UIKit
import AVFoundation

class AnimatedButton: UIButton {
    
    private var pressSoundPlayer = AVAudioPlayer()
    private var releaseSoundPlayer = AVAudioPlayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupSounds()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupSounds()
    }
    
    private func setupButton() {
        let mainColor = UIColor.black
        let bgColor = UIColor.white
        
        self.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = mainColor.cgColor
        self.backgroundColor = bgColor
        self.setTitleColor(mainColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        self.layer.shadowColor = mainColor.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        
        self.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        self.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchDragExit])
    }
    
    private func setupSounds() {

        if let pressSoundURL = Bundle.main.url(forResource: "buttonPressed", withExtension: "mp3") {
            do {
                pressSoundPlayer = try AVAudioPlayer(contentsOf: pressSoundURL)
                pressSoundPlayer.prepareToPlay()
            } catch {
                print("Error loading press sound file: \(error.localizedDescription)")
            }
        } else {
            print("Press sound file not found")
        }
        
        if let releaseSoundURL = Bundle.main.url(forResource: "buttonReleased", withExtension: "mp3") {
            do {
                releaseSoundPlayer = try AVAudioPlayer(contentsOf: releaseSoundURL)
                releaseSoundPlayer.prepareToPlay()
            } catch {
                print("Error loading release sound file: \(error.localizedDescription)")
            }
        } else {
            print("Release sound file not found")
        }
    }
    
    @objc private func buttonPressed() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.transform = CGAffineTransform(translationX: 3, y: 3)
        
        pressSoundPlayer.play()
    }
    
    @objc private func buttonReleased() {
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.transform = .identity
        
        releaseSoundPlayer.play()
    }
}
