//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var currentQuestion : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI() {
        questionLabel.text = allQuestions.list[currentQuestion].questionText
        progressLabel.text = "\(currentQuestion + 1)/13"
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(currentQuestion + 1)
    }
    

    func nextQuestion() {
        currentQuestion += 1
        
        if currentQuestion == 13 {
            
            let alert = UIAlertController(title: "Awesome", message: "Start Over?", preferredStyle: .alert)
            
            let restart = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction ) in
                self.startOver()
            })
            
            alert.addAction(restart)
            present(alert, animated: true, completion: nil)
        } else {
            updateUI()
        }
    }
    
    
    func checkAnswer() {
        let answer = allQuestions.list[currentQuestion].answer
        
        if answer == pickedAnswer {
            score += 20
            ProgressHUD.showSuccess("Correct")
        } else {
            score -= 5
            ProgressHUD.showError("Wonk WOnk")
        }
        
        nextQuestion()
    }
    
    
    func startOver() {
        currentQuestion = 0
        score = 0
        updateUI()
    }
    

    
}
