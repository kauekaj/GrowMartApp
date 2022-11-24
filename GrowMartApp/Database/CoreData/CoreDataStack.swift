//
//  CoreDataStack.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 04/11/22.
//

// Source: https://johncodeos.com/how-to-use-core-data-in-ios-using-swift/
import CoreData

class CoreDataStack {
    private let modelName: String
    private let isInMemoryStoreType: Bool

    init(modelName: String, isInMemoryStoreType: Bool = false) {
        self.modelName = modelName
        self.isInMemoryStoreType = isInMemoryStoreType
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        if isInMemoryStoreType {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = storeContainer.viewContext

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
