//
//  BrewModel.swift
//  PourOverflow
//
//  Created by Martin Granados Garcia on 2/18/21.
//

import CoreData

class BrewModel: NSManagedObject {
    @NSManaged var brewId: UUID
    @NSManaged var brewMethodRawValue: String
    @NSManaged var grainsRawValue: String?
    @NSManaged var coffee: Int
    @NSManaged var water: Int
    @NSManaged var duration: Int
    @NSManaged var creationDate: Date
    @NSManaged var brewScoreRawValue: String?
    @NSManaged var imageAddress: String?
    @NSManaged var grind: String?

    @NSManaged var aromaQuantity: Int
    @NSManaged var aromaQuality: Int
    @NSManaged var acidityQuantity: Int
    @NSManaged var acidityQuality: Int
    @NSManaged var sweetnessQuantity: Int
    @NSManaged var sweetnessQuality: Int
    @NSManaged var bodyQuantity: Int
    @NSManaged var bodyQuality: Int
    @NSManaged var finishQuantity: Int
    @NSManaged var finishQuality: Int

    @NSManaged var notes: String?
    @NSManaged var flavourNotes: String?

    static func createModelFromBrew(brew: Brew, context: NSManagedObjectContext) -> BrewModel {
        let brewModel = BrewModel(context: context)
        brewModel.brewId = brew.brewId
        brewModel.brewMethodRawValue = brew.brewMethod.rawValue
        brewModel.grainsRawValue = brew.grains?.rawValue
        brewModel.coffee = brew.coffee
        brewModel.water = brew.water
        brewModel.duration = Int(brew.duration?.value ?? -1.0)
        brewModel.brewScoreRawValue = brew.brewScore?.rawValue
        brewModel.creationDate = brew.creationDate
        brewModel.imageAddress = brew.imageAddress
        brewModel.grind = brew.grind

        brewModel.aromaQuantity = brew.aroma?.quantity ?? -1
        brewModel.aromaQuality = brew.aroma?.quality ?? -1
        brewModel.acidityQuantity = brew.acidity?.quantity ?? -1
        brewModel.acidityQuality = brew.acidity?.quality ?? -1
        brewModel.sweetnessQuantity = brew.sweetness?.quantity ?? -1
        brewModel.sweetnessQuality = brew.sweetness?.quality ?? -1
        brewModel.bodyQuantity = brew.body?.quantity ?? -1
        brewModel.bodyQuality = brew.body?.quality ?? -1
        brewModel.finishQuantity = brew.body?.quantity ?? -1
        brewModel.finishQuality = brew.body?.quality ?? -1

        brewModel.flavourNotes = brew.flavourNotes
        brewModel.notes = brew.notes

        return brewModel
    }

    init(context: NSManagedObjectContext) {
        let brewEntity = NSEntityDescription.entity(forEntityName: "BrewModel", in: context)
        guard brewEntity != nil else{
            preconditionFailure("Entity does not exist.")
        }

        super.init(entity: brewEntity!, insertInto: context)
    }
}
