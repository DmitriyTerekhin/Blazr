//
//  BlazrEntity.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 10.12.2022.
//

import Foundation
import CoreData

@objc(BlazrResult)
public final class BlazrResultDB: NSManagedObject {
    
    @NSManaged public private(set) var result: Int16
    @NSManaged public private(set) var time: Date
    @NSManaged public private(set) var question: String
    
    static func insert(into context: NSManagedObjectContext, blazrResult: BlazrResult) -> BlazrResultDB {
        let blazrDB: BlazrResultDB = context.insertObject()
        blazrDB.time = blazrResult.time
        blazrDB.result = Int16(blazrResult.diceResult.value)
        blazrDB.question = blazrResult.question
        return blazrDB
    }
}

extension BlazrResultDB: ManagedObjectType {
    static var entityName: String {
        "BlazrResult"
    }
    
    static var bySurnameSortDescriptor: [NSSortDescriptor] = [
        NSSortDescriptor(key: "time", ascending: true)
    ]
}
