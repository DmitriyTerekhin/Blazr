//
//  DatabaseService.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 10.12.2022.
//

import Foundation
import CoreData

protocol IDatabaseService {
    func saveResult(result: BlazrResult, completionHandler: FinishedCompletionHandler)
    func getResults(with predicate: NSPredicate?) -> [BlazrResult]
    func deleteAllBlazrs(completionHandler: FinishedCompletionHandler)
}

class DatabaseService: IDatabaseService {
    
    func saveResult(result: BlazrResult, completionHandler: FinishedCompletionHandler) {
        db.saveResult(result: result, with: CDStack.mainContext, completionHandler: completionHandler)
    }
    
    func getResults(with predicate: NSPredicate?) -> [BlazrResult] {
        db.getResults(withPredicate: predicate, by: CDStack.mainContext).map({ BlazrResult(fromDB: $0)})
    }
    
    func deleteAllBlazrs(completionHandler: FinishedCompletionHandler) {
        db.deleteAllBlazrs(context: CDStack.mainContext, completion: completionHandler)
    }
    
    private let db: IStorageManager
    private let CDStack: ICoreDataStack
    
    init(db: IStorageManager, coreDataStack: ICoreDataStack) {
        self.db = db
        self.CDStack = coreDataStack
    }
}
