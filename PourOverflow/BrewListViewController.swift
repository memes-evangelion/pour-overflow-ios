//
//  BrewListViewController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewListViewController: UITableViewController {
    var brewStore: BrewStore!
    var selectedDay: Date?
    var selectedBrews: [Brew]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedDay != nil {
            selectedBrews = brewStore.brewsInDate(date: selectedDay!)
        } else {
            selectedBrews = brewStore.allBrews
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBrews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrewCell", for: indexPath)
        let brew = selectedBrews[indexPath.row]

        cell.textLabel?.text = "\(brew.brewMethod)"
        if let score = brew.brewScore?.rawValue {
            cell.detailTextLabel?.text = score
        } else {
            cell.detailTextLabel?.text = "-"
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showBrew":
            if let row = tableView.indexPathForSelectedRow?.row {
                let brew = selectedBrews[row]
                if let brewDetailViewController = segue.destination as? BrewDetailViewController {
                    brewDetailViewController.brew = brew
                }
            }
        default:
            preconditionFailure("Unexpected segue")
        }
    }
}
