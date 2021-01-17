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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrewCell", for: indexPath)
        
        let brew = brewStore.allBrews[indexPath.row]
        
        cell.textLabel?.text = "\(brew.brewMethod)"
        cell.detailTextLabel?.text = "\(brew.score)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showBrew":
            if let row = tableView.indexPathForSelectedRow?.row {
                let brew = brewStore.allBrews[row]
                let brewDetailViewController = segue.destination as! BrewDetailViewController
                brewDetailViewController.brew = brew
            }
        default:
            preconditionFailure("Unexpected segue")
        }
    }
}