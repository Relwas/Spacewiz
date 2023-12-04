import Foundation

struct QuizQuestion: Codable {
    let question: String
    let options: [String]
    let correctOption: String
}

import UIKit

@available(iOS 13.0, *)
class QuizQuestionViewController: UIViewController {

    
    
    var quizQuestions: [QuizQuestion] = []
    var currentQuestionIndex = 0
    var selectedOptions: [String?] = []

    // UI Elements
    let earthImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Earth"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont(name: "EuphemiaUCAS", size: 18)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    var answerButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Fon")

        
        setupUI()
        setupConstraints()

        setupUIForCurrentQuestion()

        startLoopingAnimation()
    }

    func setupUI() {
        view.addSubview(earthImageView)
        view.addSubview(questionLabel)

        // Create answer buttons and add to the array
        for _ in 0..<4 {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(named: "fonForButtonAnswer")
            button.layer.cornerRadius = 10
            button.tintColor = UIColor.black
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 2.5
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            answerButtons.append(button)
            view.addSubview(button)

        }
    }

    func setupConstraints() {
           NSLayoutConstraint.activate([
               earthImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               earthImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -180),
               earthImageView.widthAnchor.constraint(equalToConstant: 250),
               earthImageView.heightAnchor.constraint(equalToConstant: 250)
           ])

           // Constraints for the question label
           NSLayoutConstraint.activate([
               questionLabel.topAnchor.constraint(equalTo: earthImageView.bottomAnchor, constant: 15),
               questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           ])

           // Create a container view for the answer buttons
           let buttonsContainerView = UIView()
           buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(buttonsContainerView)

           NSLayoutConstraint.activate([
               buttonsContainerView.topAnchor.constraint(equalTo: earthImageView.bottomAnchor, constant: 210),
               buttonsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           ])

           for (index, button) in answerButtons.enumerated() {
               NSLayoutConstraint.activate([
                   button.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: CGFloat(55 * index)),
                   button.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
                   button.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor),
                   
                   button.heightAnchor.constraint(equalToConstant: 45),
               ])
           }
       }
    func setupUIForCurrentQuestion() {
        guard currentQuestionIndex < quizQuestions.count else {
            showQuizResult()
            return
        }

        let currentQuestion = quizQuestions[currentQuestionIndex]

        earthImageView.image = UIImage(named: "Earth")
        questionLabel.text = currentQuestion.question

        for (index, button) in answerButtons.enumerated() {
            if index < currentQuestion.options.count {
                button.setTitle(currentQuestion.options[index], for: .normal)
                button.isHidden = false
            } else {
                // Hide unused buttons
                button.isHidden = true
            }
        }

        if currentQuestionIndex == quizQuestions.count - 1 {
            showQuizResult()
        }
    }

    @objc func optionSelected(_ sender: UIButton) {
        if let selectedOption = sender.title(for: .normal) {
            selectedOptions.append(selectedOption)
        }

        currentQuestionIndex += 1

        setupUIForCurrentQuestion()
    }

    @objc func backToMainScreen() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    func calculateUserScore() -> Int {
        var score = 0

        for (index, question) in quizQuestions.enumerated() {
            guard index < selectedOptions.count else {
                break
            }

            if selectedOptions[index] == question.correctOption {
                score += 1
            }
        }

        return score
    }

    func showQuizResult() {
        print("showQuizResult called")
        let userScore = calculateUserScore()
        let quizResultVC = QuizResultViewController()
        quizResultVC.userScore = userScore
        
        // Present the QuizResultViewController
        navigationController?.pushViewController(quizResultVC, animated: true)
    }

    func startLoopingAnimation() {
        // Create a basic rotation animation
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [0, CGFloat.pi * 2]
        rotationAnimation.keyTimes = [0, 1]
        rotationAnimation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
        rotationAnimation.duration = 40.0
        rotationAnimation.repeatCount = .greatestFiniteMagnitude

        // Apply the rotation animation
        self.earthImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }



}
