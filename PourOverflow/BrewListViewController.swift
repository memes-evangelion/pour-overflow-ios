//
//  BrewListViewController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewListViewController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar!

    var brewStore: BrewStore!
    var selectedDay: Date?

    var sectionNames: [String]!
    var selectedBrewsBySections: [[Brew]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedDay != nil {
            let selectedBrews = brewStore.brewsInDate(date: selectedDay!)
            let sectionsByDay = BrewUtilities.sectionsByDay(brews: selectedBrews)
            sectionNames = sectionsByDay.0
            selectedBrewsBySections = sectionsByDay.1
            tableView.tableHeaderView = nil
        } else {
            let selectedBrews = brewStore.allBrews
            let sectionsByMonth = BrewUtilities.sectionsByMonth(brews: selectedBrews)
            sectionNames = sectionsByMonth.0
            selectedBrewsBySections = sectionsByMonth.1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBrewsBySections[section].count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrewCell", for: indexPath)
        let brew = selectedBrewsBySections[indexPath.section][indexPath.row]

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
            if let indexPath = tableView.indexPathForSelectedRow {
                let brew = selectedBrewsBySections[indexPath.section][indexPath.row]
                if let brewDetailViewController = segue.destination as? BrewDetailViewController {
                    brewDetailViewController.brew = brew
                }
            }
        default:
            preconditionFailure("Unexpected segue")
        }
    }
}
