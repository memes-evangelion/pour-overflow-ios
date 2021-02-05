//
//  BrewListViewController.swift
//  PourOverflow
//
//  Created by marto on 17/01/21.
//

import UIKit

class BrewListViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!

    var brewStore: BrewStore!
    var selectedDay: Date?

    var sectionNames: [String]!
    var selectedBrewsBySections: [[Brew]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self

        if selectedDay != nil {
            let selectedBrews = brewStore.brewsInDate(date: selectedDay!)
            let sectionsByDay = BrewUtilities.sectionsByDay(brews: selectedBrews)
            sectionNames = sectionsByDay.0
            selectedBrewsBySections = sectionsByDay.1
            tableView.tableHeaderView = nil
        } else {
            setBrewsByMonth(brews: brewStore.allBrews)
        }
    }

    func setBrewsByMonth(brews: [Brew]) {
        let sectionsByMonth = BrewUtilities.sectionsByMonth(brews: brews)
        sectionNames = sectionsByMonth.0
        selectedBrewsBySections = sectionsByMonth.1
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let matchingMethods = BrewMethod.matchingMethods(text: searchText)
        if matchingMethods.isEmpty {
            setBrewsByMonth(brews: brewStore.allBrews)
        } else {
            let brewsFound = brewStore.brewsByMethod(brewMethods: matchingMethods, fromDate: nil, toDate: nil)
            setBrewsByMonth(brews: brewsFound)
        }
        tableView.reloadData()
    }
}
