//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by Troopy on 08/01/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct Quiz {
    var question : String
    var answerOptions : [String]
    var solution : String
}

var questionIndex = Int()


//FINISHED
struct QuestionProvider
{
    var questions: [Quiz] = [
        Quiz(question : "This was the only US President to serve more than two consecutive terms.",answerOptions :["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], solution : "Franklin D. Roosevelt"),
        Quiz(question: "Which of the following countries has the most residents?",answerOptions : ["Nigeria", "Russia", "Iran", "Vietnam"],solution : "Nigeria"),
        Quiz(question: "In what year was the United Nations founded?", answerOptions : ["1918", "1919", "1945", "1954"], solution : "1945"),
        Quiz(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answerOptions : ["Paris", "Washington D.C.", "New York City", "Boston"], solution : "New York City"),
        Quiz(question: "Which nation produces the most oil?", answerOptions :["Iran", "Iraq", "Brazil", "Canada"],solution : "Canada"),
        Quiz(question: "Which country has most recently won consecutive World Cups in Soccer?", answerOptions: ["Italy", "Brazil", "Argetina", "Spain"], solution : "Brazil"),
        Quiz(question: "Which of the following rivers is longest?", answerOptions : ["Yangtze", "Mississippi", "Congo", "Mekong"], solution: "Mississippi"),
        Quiz(question: "Which city is the oldest?",answerOptions : ["Mexico City","Cape Town","San Juan","Sydney"], solution : "Mexico City"),
        Quiz(question: "Which country was the first to allow women to vote in national elections?",answerOptions :["Poland", "United States", "Sweden", "Senegal"], solution : "Poland"),
        Quiz(question: "Which of these countries won the most medals in the 2012 Summer Games?", answerOptions : ["France", "Germany", "Japan", "Great Britian"], solution : "Great Britian")
    ]

        var beenAsked = [Quiz]()

    func getRandomNumber()
    {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        questionIndex = randomNumber
    }
    func randomQuestion(questionIndex: Int) -> String {
        let chosenQAKey = questions[questionIndex]
        return chosenQAKey.question
    }
    // func to get answers for the generated question
    func getAnswers(questionIndex: Int) -> [String]
    {
        let chosenQuestion = questions[questionIndex]
        return chosenQuestion.answerOptions
    }
    func correctAnswer(questionIndex: Int) -> String
    {
        let selectedQuestion = questions[questionIndex]
        return selectedQuestion.solution
    }
}
var answeredQuestionIndexCollection = [Quiz]()

