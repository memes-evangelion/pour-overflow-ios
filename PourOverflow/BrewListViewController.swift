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
            let selectedBrews = brewStore.brewsInDate(date: selectedDay!)
            let sectionsByMethod = BrewUtilities.sectionsByDay(brews: selectedBrews)
            monthSections = sectionsByMethod.0
            selectedBrewsByMonth = sectionsByMethod.1
        } else {
            let selectedBrews = brewStore.allBrews
            let sectionsByMonth = BrewUtilities.sectionsByMonth(brews: selectedBrews)
            monthSections = sectionsByMonth.0
            selectedBrewsByMonth = sectionsByMonth.1

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
