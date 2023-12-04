import UIKit

@available(iOS 13.0, *)
class QuizResultViewController: UIViewController {
    var userScore: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

        view.backgroundColor = UIColor(named: "Fon")
        print("QuizResultViewController - View Did Load")

        let core = Core.shared
        let userName = core.getUserName() ?? ""
        core.saveUserName(userName)

        let imageView = UIImageView(image: UIImage(named: "ResultImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            imageView.widthAnchor.constraint(equalToConstant: 450), // Adjust the width as needed
            imageView.heightAnchor.constraint(equalToConstant: 200) // Adjust the height as needed
        ])

        // Create the score label
        // Create the score label
        let scoreLabel = UILabel()
        scoreLabel.text = "Congratulations \(userName)! Your Score: \(userScore)"
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "EuphemiaUCAS", size: 18)
        scoreLabel.numberOfLines = 2
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), // Adjust the top constraint
            scoreLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40), // Adjust the width as needed
        ])


        // Optionally, you can display a congratulations message based on the user's score
        let congratulationsLabel = UILabel()
        congratulationsLabel.font = UIFont(name: "DevanagariSangamMN-Bold", size: 18)

        congratulationsLabel.text = userScore >= 10 ? "Congratulations!" : "Nice try!"
        congratulationsLabel.textAlignment = .center
        congratulationsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(congratulationsLabel)

        NSLayoutConstraint.activate([
            congratulationsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            congratulationsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20)
        ])

        // Add a button to navigate back to the main screen or perform any other action
        let backButton = UIButton(type: .system)
        backButton.backgroundColor = UIColor(named: "fonForButtonAnswer")
        backButton.layer.cornerRadius = 10
        backButton.tintColor = UIColor.black
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButton.layer.shadowOpacity = 0.3
        backButton.layer.shadowRadius = 2.5
        backButton.setTitle("Back to Main Screen", for: .normal)
        backButton.addTarget(self, action: #selector(backToMainScreen), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor, constant: 190),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
    }

    @objc func backToMainScreen() {
        dismiss(animated: true, completion: nil)
    }
}
