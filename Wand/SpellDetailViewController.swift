//
//  SpellDetailViewController.swift
//  Wand
//
//  Created by Romain Francois on 19/07/2020.
//  Copyright © 2020 Romain Francois. All rights reserved.
//

import UIKit
import AVFoundation

class SpellDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var spellData: SpellData!
    
    var audioPlayer: AVAudioPlayer!
    
    var nameX: CGFloat!
    var descriptionX: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Likely will never occur, but you can ...
        if spellData == nil {
            spellData = SpellData(name: "", description: "", soundFile: "")
        }
        
        // Save original location so we can animate back to this spot. Only the x value will change since we're moving horizontally
        nameX = nameLabel.frame.origin.x
        descriptionX = descriptionLabel.frame.origin.x
        
        // move the upper left point of the 2 labels so it's just off screen, to the right of the view controller
        nameLabel.frame.origin.x = self.view.frame.width
        descriptionLabel.frame.origin.x = self.view.frame.width
        
        updateUserInterface()
    }
    
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print(" ERROR: \(error.localizedDescription)")
            }
        } else {
            print("ERROR: Could not read data from file \(name)")
        }
    }

    func clearUserInterface() {
        nameLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func updateUserInterface() {
        nameLabel.text = spellData.name
        descriptionLabel.text = spellData.description
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.nameLabel.frame.origin.x = self.nameX
            }
        )
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0.25,
            animations: {
                self.descriptionLabel.frame.origin.x = self.descriptionX
            }
        )
    }
    
    func castSpell() {
        playSound(name: spellData.soundFile)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 1.0,
            animations: {
                self.view.backgroundColor = .red
        }) { (_) in
            self.view.backgroundColor = .white
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        castSpell()
    }
    
    @IBAction func viewSwipped(_ sender: UISwipeGestureRecognizer) {
        castSpell()
    }
    
}
