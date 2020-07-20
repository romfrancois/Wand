//
//  ViewController.swift
//  Wand
//
//  Created by Romain Francois on 19/07/2020.
//  Copyright © 2020 Romain Francois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var spells = Spells()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        spells.spellArray.append(SpellData(name: "spell1", description: "", soundFile: ""))
//        tableView.reloadData()
        
        spells.getData {
            DispatchQueue.main.async {                
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! SpellDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            
            destination.spellData = spells.spellArray[selectedIndexPath.row]
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spells.spellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default behaviour for tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = spells.spellArray[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
