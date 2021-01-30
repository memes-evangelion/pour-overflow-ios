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

    var monthSections: [String]!
    var selectedBrewsByMonth: [[Brew]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedDay != nil {
            let selectedBrewsMonths = brewStore.brewsInDateByMethod(date: selectedDay!)
            monthSections = selectedBrewsMonths.0
            selectedBrewsByMonth = selectedBrewsMonths.1
        } else {
            let selectedBrewsMonths = brewStore.allBrewsByMonth()
            monthSections = selectedBrewsMonths.0
            selectedBrewsByMonth = selectedBrewsMonths.1

        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBrewsByMonth[section].count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return monthSections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return monthSections[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrewCell", for: indexPath)
        let brew = selectedBrewsByMonth[indexPath.section][indexPath.row]

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
                let brew = selectedBrewsByMonth[indexPath.section][indexPath.row]
                if let brewDetailViewController = segue.destination as? BrewDetailViewController {
                    brewDetailViewController.brew = brew
                }
            }
        default:
            preconditionFailure("Unexpected segue")
        }
    }
}
