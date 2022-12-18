//
//  CreatingQuestionPresenter.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 09.12.2022.
//

import Foundation

protocol ICreatingQuestionPresenter: AnyObject {
    var diceResult: Int? { get }
    func getRandomNumber() -> Int
    func saveResult(question: String)
    func isPremiumActive() -> Bool
}
protocol ICreatingQuestionView: AnyObject {}

class CreatingQuestionPresenter: ICreatingQuestionPresenter {
    
    var diceResult: Int?
    private let databaseService: IDatabaseService
    private let settingsService: ISensentiveInfoService
    
    init(
        databaseService: IDatabaseService,
        settingsService: ISensentiveInfoService
    ) {
        self.databaseService = databaseService
        self.settingsService = settingsService
    }
    
    func isPremiumActive() -> Bool {
        settingsService.isPremiumActive()
    }
    
    func getRandomNumber() -> Int {
        diceResult = Int.random(in: 1..<6)
        return diceResult ?? 0
    }
    
    func saveResult(question: String) {
        guard
            question.count > 3,
            let diceResult = diceResult,
            let result = DiceResult(number: diceResult)
        else { return }
        databaseService.saveResult(result: BlazrResult(question: question,
                                                       diceResult: result),
                                   completionHandler: { _ in })
    }
}
