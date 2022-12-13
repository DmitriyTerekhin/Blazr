//
//  CreatingDiceModel.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import Foundation

enum CreatingDiceViewState {
    case initial
    case startCreating
    case addingQuestion
    case checking
    case letsDice
    case loading
    case showResult(result: DiceResult)
}

enum DiceResult {
    case yes(count: Int)
    case no(count: Int)
    case dontKnow
    
    init?(number: Int) {
        switch number {
        case 1,2:
            self = .yes(count: number)
        case 3:
            self = .dontKnow
        case 4,5:
            self = .no(count: number)
        default:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .yes(_):
            return "Here is the result. Yes!"
        case .no(_):
            return "Here is the result. No!"
        case .dontKnow:
            return "I don’t know. Try later!"
        }
    }
    
    var value: Int {
        switch self {
        case .yes(let count):
            return count
        case .no(let count):
            return count
        case .dontKnow:
            return 3
        }
    }
}

struct BlazrResult {
    let question: String
    let diceResult: DiceResult
    let time: Date
    
    init(question: String, diceResult: DiceResult) {
        time = Date()
        self.question = question
        self.diceResult = diceResult
    }
    
    init(fromDB: BlazrResultDB) {
        self.time = fromDB.time
        self.question = fromDB.question
        self.diceResult = DiceResult(number: Int(exactly: fromDB.result)!)!
    }
}
