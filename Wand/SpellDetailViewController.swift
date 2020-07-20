//
//  SpellDetailViewController.swift
//  Wand
//
//  Created by Romain Francois on 19/07/2020.
//  Copyright © 2020 Romain Francois. All rights reserved.
//

import UIKit

class SpellDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var spellData: SpellData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Likely will never occur, but you can ...
        if spellData == nil {
            spellData = SpellData(name: "", description: "", soundFile: "")
        }
        
        updateUserInterface()
    }

    func clearUserInterface() {
        nameLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func updateUserInterface() {
        nameLabel.text = spellData.name
        descriptionLabel.text = spellData.description
    }
}
