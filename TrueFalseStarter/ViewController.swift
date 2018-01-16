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

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    //We link up que VC with QProvider
    let questions = QuestionProvider().questions
    
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion()
    {
        var questionDictionary : [String:String] = [:]
        var continuePlay :Bool = true
        while continuePlay
        {
            print(indexOfSelectedQuestion)
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
            if questions[indexOfSelectedQuestion]["alreadyAsked"] == "false"
            {
                print("ADDING")
                questionDictionary = questions[indexOfSelectedQuestion]
                questionDictionary["alreadyAsked"] = "true"
                continuePlay = false
            }
        }
        print("TOMA")
        questionField.text = questionDictionary["Question"]
        answer1.setTitle(questionDictionary["option1"], for: UIControlState.normal)
        answer2.setTitle(questionDictionary["option2"], for: UIControlState.normal)
        answer3.setTitle(questionDictionary["option3"], for: UIControlState.normal)
        answer4.setTitle(questionDictionary["option4"], for:UIControlState.normal)
        playAgainButton.isHidden = true
        print("Displayed")
    }
    
    func displayScore() {
        // Hide the answer buttons
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        answer4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    // Action you do when you press the button
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        // Increment the questions asked counter
        questionsAsked += 1
        let selectedQuestionDict = questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        //swift case (Change it)
        if(sender === answer1 &&  correctAnswer == answer1.titleLabel?.text!) || (sender === answer2 && correctAnswer == answer2.titleLabel?.text!) || (sender === answer3 &&  correctAnswer == answer3.titleLabel?.text!) || (sender === answer4 && correctAnswer == answer4.titleLabel?.text!)
        {
            print("CORRECT")
            correctQuestions += 1
            questionField.text = "Correct!"
        } else { questionField.text = "Sorry, wrong answer!" }
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound()
    {
        if questionsAsked == questionsPerRound
        {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain()
    {
        // Show the answer buttons
        answer1.isHidden = false
        answer2.isHidden = false
        answer3.isHidden = false
        answer4.isHidden = false
        
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

