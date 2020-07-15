
import CoreData
import Foundation

class CoreDataManager {
    
    private var storeType: String!
       
    lazy var persistentContainer: NSPersistentContainer! = {
        var persistentContainer = NSPersistentContainer(name: "Logs")
        let description = persistentContainer.persistentStoreDescriptions.first
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    // MARK: - Singleton
    
    static let shared = CoreDataManager()
    
    // MARK: - SetUp
    
    func setup(storeType: String = NSSQLiteStoreType, completion: (() -> Void)?=nil) {
        self.storeType = storeType
        
        loadPersistentStore{
            completion?()
        }
    }
    
    // MARK: - Loading
    
    private func loadPersistentStore(completion: @escaping () -> Void) {
        //handle data migration here
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
            completion()

        }
    }
}

