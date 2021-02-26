//
//  CoreDataBrewStore.swift
//  PourOverflow
//
//  Created by Martin Granados Garcia on 2/18/21.
//
import CoreData

class CoreDataBrewStore: BrewStore {
    var allBrews: [Brew] {
        get {
            let context = container.viewContext
            do {
                let allBrewModels = try context.fetch(BrewModel.brewFetchRequest())
                return allBrewModels.map { Brew(from: $0) }
            } catch {
                print("Error querying Brew Models")
            }
            return []
        }
    }

    let container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "Brews")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Could not load persistant store")
            }
        }
        return container
    }()

    func brewsInDateRange(fromDate: Date, toDate: Date) -> [Brew] {
        let context = container.viewContext
        let fetchRequest = BrewModel.brewFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "creationDate >= %@ && creationDate <= %@", argumentArray: [fromDate, toDate])
        do {
            let brews = try context.fetch(fetchRequest)
            let brewsInDateRange =  brews.map { Brew(from: $0) }
            return brewsInDateRange.sorted {
                $0.creationDate < $1.creationDate
            }
        } catch {
            print("Error fetching brews in date range")
        }
        return []
    }

    func saveBrew(brew: Brew) {
        let context = container.viewContext
        let _ = BrewModel.createModelFromBrew(brew: brew, context: context)
        do {
            try context.save()
        } catch {
            print("Error saving context")
        }
    }
}
