import UIKit

@available(iOS 13.0, *)
class QuizViewController: UIViewController {

    var questions: [QuizQuestion] = []
    var currentQuestionIndex = 0
    var userScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let core = Core.shared
        let userName = core.getUserName() ?? ""
        core.saveUserName(userName)

        view.backgroundColor = UIColor(named: "Fon")

        loadQuestions()

        let imageView = UIImageView(image: UIImage(named: "imageForQuizView"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Get ready, \(userName)! Explore the cosmos in this astronomical quiz. From star births to black hole secrets, test your knowledge on recent cosmic discoveries. Let the cosmic journey begin!"
        label.font = UIFont(name: "Futura-Medium", size: 18)
        label.numberOfLines = 0
        view.addSubview(label)

        let startQuizButton = UIButton(type: .system)
        startQuizButton.setTitle("Start Quiz", for: .normal)
        startQuizButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        startQuizButton.translatesAutoresizingMaskIntoConstraints = false
        startQuizButton.backgroundColor = UIColor.systemGray
        startQuizButton.tintColor = .white
        startQuizButton.layer.cornerRadius = 10
        view.addSubview(startQuizButton)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.8),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: view.bounds.height * 0.05),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.05),

            startQuizButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startQuizButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            startQuizButton.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.05),
            startQuizButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height * 0.1)
        ])
    }

    @objc func startQuiz() {
        guard !questions.isEmpty else {
            print("No questions available")
            return
        }

        questions.shuffle()

        print("Number of questions: \(questions.count)")

        let quizQuestionVC = QuizQuestionViewController()
        quizQuestionVC.quizQuestions = questions
        let quizQuestionNavController = UINavigationController(rootViewController: quizQuestionVC)
        quizQuestionNavController.modalPresentationStyle = .fullScreen
        present(quizQuestionNavController, animated: true, completion: nil)
    }

    func showQuestion() {
        guard currentQuestionIndex < questions.count else {
            return
        }
        _ = questions[currentQuestionIndex]

        currentQuestionIndex += 1
    }

    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "quiz_data", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let topicQuestions = try? JSONDecoder().decode([QuizQuestion].self, from: data) {

            questions = Array(topicQuestions.shuffled().prefix(15))
        }
    }
}
