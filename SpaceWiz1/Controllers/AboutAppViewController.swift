import UIKit

class AboutAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Fon")
        navigationController?.navigationBar.isHidden = false

        // Create a scroll view
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

        view.addSubview(scrollView)

        // Create a label for the welcome message
        let welcomeLabel: UILabel = {
            let label = UILabel()
            label.text = "Welcome to Celestial Explorer, an immersive educational experience that invites you to unravel the mysteries of the universe!"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "AvenirNext-Bold", size: 18)
            label.textColor = UIColor(named: "YourTextColor") // Set your desired text color
            return label
        }()

        // Create a label for the about app section
        let aboutAppLabel: UILabel = {
            let label = UILabel()
            label.text = "About App:\nCelestial Explorer brings the captivating content of \"Fundamental Astronomy\" to your fingertips, offering an in-depth exploration of the cosmos. Immerse yourself in a cosmic adventure as you navigate through 449 illustrations, including 34 colour plates, each providing a visual spectacle of our vast universe."
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "AvenirNext-Regular", size: 18)
            label.textColor = UIColor(named: "YourTextColor") // Set your desired text color
            return label
        }()

        // Create a label for the key features section
        let keyFeaturesLabel: UILabel = {
            let label = UILabel()
            label.text = "Key Features:\n1. **Educational Insights:** Dive into a treasure trove of astronomical knowledge derived directly from the pages of the book. From the fundamentals of celestial mechanics to the intricacies of observational astronomy, our app delivers an engaging learning experience.\n\n2. **Quiz Tests:** Test your astronomical acumen with interactive quizzes. With 100 questions, challenge yourself to master the complexities of astronomy and expand your understanding of the cosmos.\n\n3. **Visual Delights:** Explore breathtaking visuals that accompany the text, offering a visual feast of celestial wonders. From planetary systems to distant galaxies, each image tells a story of the beauty and grandeur of our universe.\n\n4. **Interactive Learning:** Engage with the content through an intuitive and user-friendly interface. Whether you're a novice stargazer or a seasoned astronomer, Celestial Explorer caters to all levels of curiosity."
            label.numberOfLines = 0
            label.textAlignment = .left
            label.font = UIFont(name: "AvenirNext-Regular", size: 18)
            label.textColor = UIColor(named: "YourTextColor") // Set your desired text color
            return label
        }()

        // Create a label for the closing message
        let closingLabel: UILabel = {
            let label = UILabel()
            label.text = "Join us on this cosmic odyssey as we unlock the secrets of the night sky. Celestial Explorer is more than an app; it's a portal to the vastness of space, inviting you to become a steward of the cosmos. Prepare to embark on a journey of discovery and wonder!\n\nHappy Exploring,\nSpacewiz Team"
            label.numberOfLines = 0
            label.textAlignment = .justified
            label.font = UIFont(name: "AvenirNext-Regular", size: 18)
            label.textColor = UIColor(named: "YourTextColor") // Set your desired text color
            return label
        }()

        // Add labels to the scroll view
        [welcomeLabel, aboutAppLabel, keyFeaturesLabel, closingLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }

        // Set up constraints for the labels
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            aboutAppLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            aboutAppLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            aboutAppLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            keyFeaturesLabel.topAnchor.constraint(equalTo: aboutAppLabel.bottomAnchor, constant: 20),
            keyFeaturesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            keyFeaturesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            closingLabel.topAnchor.constraint(equalTo: keyFeaturesLabel.bottomAnchor, constant: 20),
            closingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closingLabel.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -20)
        ])

        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
