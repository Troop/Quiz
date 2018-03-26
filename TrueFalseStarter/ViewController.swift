//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController{
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var correctSolution = ""
    var gameQuestions = QuestionProvider()
    
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadGameStartSound()
        //StartGame
        playGameStartSound()
        displayQuestion()
        displayAnswer()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //FUNC HIDE BUTTONS
    func hideButtons()
    {
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        answer4.isHidden = true
    }
    
    //FIXED UNTIL HERE
    //NO THE PROBLEM
    func displayQuestion()
    {
        let number = questionIndex
        let question = gameQuestions.randomQuestion(questionIndex : number)
        questionField.text = question
    }
    func displayAnswer()
    {
        let number = questionIndex
        let answerOptions = gameQuestions.getAnswers(questionIndex: number)
        print(answerOptions, indexOfSelectedQuestion)
        //correctSolution = gameQuestions.correctAnswer(questionIndex: indexOfSelectedQuestion)
        answer1.setTitle(answerOptions[0], for: .normal)
        answer2.setTitle(answerOptions[1], for: .normal)
        answer3.setTitle(answerOptions[2], for: .normal)
        answer4.setTitle(answerOptions[3], for: .normal)
        playAgainButton.isHidden = true
    }
    
    func reviveQuestion()
     {
        gameQuestions.questions.append(contentsOf: gameQuestions.beenAsked)
        gameQuestions.beenAsked.removeAll()
     }
    func removeQuestions()
    {
        gameQuestions.beenAsked.append(gameQuestions.questions[questionIndex])
        gameQuestions.questions.remove(at: questionIndex)
    }
    
    func displayScore()
    {
        // Hide the answer buttons
        hideButtons()
        //Checking Answers
        if correctQuestions == 4
        {
            questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        }
        else
        {
            questionField.text = "Sorry!\nYou got things to learn  \(correctQuestions) out of \(questionsPerRound) correct..."
        }
        playAgainButton.isHidden = false
    }
    // Action you do when you press the button
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        questionsAsked += 1
        if(sender === answer1 && answer1.titleLabel!.text == gameQuestions.correctAnswer(questionIndex: questionIndex)) ||
          (sender === answer2 && answer2.titleLabel!.text == gameQuestions.correctAnswer(questionIndex: questionIndex)) ||
          (sender === answer3 && answer3.titleLabel!.text == gameQuestions.correctAnswer(questionIndex: questionIndex)) ||
          (sender === answer4 && answer4.titleLabel!.text == gameQuestions.correctAnswer(questionIndex: questionIndex))
        {

            correctQuestions += 1
            questionField.text = "Correct!"
        }
        else
        {
            questionField.text = "Sorry, wrong answer!"
        }
        removeQuestions()
        loadNextRoundWithDelay(seconds: 1)
    }
    //CHECKPOINT
    func nextRound()
    {
        if questionsAsked == questionsPerRound
        {
            // Game is over
            displayScore()
        } else {
            // Continue game
            gameQuestions.getRandomNumber()
            displayQuestion()
            displayAnswer()
        }
    }
    
    @IBAction func playAgain()
    {
        // Show the answer buttons
        answer1.isHidden = false
        answer2.isHidden = false
        answer3.isHidden = false
        answer4.isHidden = false
        //REMOVE QUESTIONS FROM GAME
        reviveQuestion()
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

