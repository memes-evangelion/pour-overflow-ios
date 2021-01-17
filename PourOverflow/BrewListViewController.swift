//
//  BrewListViewController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewListViewController: UITableViewController {
    var brewStore: BrewStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewStore.allBrews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "BrewCell")
        
        let brew = brewStore.allBrews[indexPath.row]
        
        cell.textLabel?.text = "\(brew.brewMethod)"
        cell.detailTextLabel?.text = "\(brew.score)"
        
        return cell
    }
}
