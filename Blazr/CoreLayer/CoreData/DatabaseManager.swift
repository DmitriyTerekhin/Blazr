//
//  DatabaseManager.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 10.12.2022.
//

import Foundation
import CoreData

protocol IStorageManager: AnyObject {
    func saveResult(result: BlazrResult, with context: NSManagedObjectContext, completionHandler: FinishedCompletionHandler)
    func getResults(withPredicate: NSPredicate?, by context: NSManagedObjectContext) -> [BlazrResultDB]
}

class DatabaseStorage: IStorageManager {
    func saveResult(result: BlazrResult, with context: NSManagedObjectContext, completionHandler: FinishedCompletionHandler) {
        context.performAndWait {
            _ = BlazrResultDB.insert(into: context, blazrResult: result)
        }
        _ = context.saveOrRollback()
        completionHandler(true)
    }
    
    func getResults(withPredicate: NSPredicate?, by context: NSManagedObjectContext) -> [BlazrResultDB] {
        return BlazrResultDB.fetch(in: context, configurationBlock: { request in request.predicate = withPredicate})
    }
}
