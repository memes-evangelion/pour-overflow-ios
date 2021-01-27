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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedDay != nil {
            return brewStore.brewsInDate(date: selectedDay!).count
        }
        return brewStore.allBrews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrewCell", for: indexPath)
        var brew = brewStore.allBrews[indexPath.row]

        if selectedDay != nil {
            brew = brewStore.brewsInDate(date: selectedDay!)[indexPath.row]
        }

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
                var brew = brewStore.allBrews[row]
                if selectedDay != nil {
                    brew = brewStore.brewsInDate(date: selectedDay!)[row]
                }
                if let brewDetailViewController = segue.destination as? BrewDetailViewController {
                    brewDetailViewController.brew = brew
                }
            }
        default:
            preconditionFailure("Unexpected segue")
        }
    }
}
