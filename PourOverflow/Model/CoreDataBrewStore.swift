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
        return []
    }

    func brewsInDate(date: Date) -> [Brew] {
        return []
    }

    func brewsByMethod(brewMethods: [BrewMethod], fromDate: Date?, toDate: Date?) -> [Brew] {
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
