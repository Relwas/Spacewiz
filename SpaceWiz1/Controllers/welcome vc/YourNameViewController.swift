//
//  ViewController.swift
//  SpaceWiz1
//
//  Created by relwas on 01/12/23.
//

import UIKit

@available(iOS 13.0, *)
class YourNameViewController: UIViewController, UITextFieldDelegate {

    private let storage = StorageManager()
    
    let enterLastLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your name to start the space journey."
        label.textColor = UIColor(named: "forLabelColor")
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor(named: "Fon1")
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 12
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.backgroundColor = UIColor(named: "textField")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ok", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        nameTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    func setupUI() {
        view.backgroundColor = UIColor(named: "Fon")
        view.addSubview(enterLastLabel)
        view.addSubview(enterNameLabel)
        view.addSubview(nameTextField)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            enterLastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterLastLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * 0.2),
            enterLastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            enterLastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.05),

            enterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameLabel.topAnchor.constraint(equalTo: enterLastLabel.bottomAnchor, constant: view.bounds.height * 0.07),

            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: enterNameLabel.bottomAnchor, constant: view.bounds.height * 0.02),
            nameTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: view.bounds.height * 0.05),
            saveButton.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.05),
            saveButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.35)
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func saveButtonTapped() {
        if nameTextField.hasText {
            let enteredName = nameTextField.text!

            Core.shared.saveUserName(enteredName)
            print("Data saved: \(enteredName)")

            storage.set(enteredName, forKey: .textFiltdText)

            let tabController = TabViewController()
            tabController.modalPresentationStyle = .fullScreen

            if let navigationController = navigationController {
                navigationController.setViewControllers([tabController], animated: true)
            } else {
                present(tabController, animated: true, completion: nil)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        if Core.shared.isNewUser() {
            let vc = WelcomeViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}



class WelcomeViewController: UIViewController {

    lazy var buttonB: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.layer.cornerRadius = 10
//        but.tintColor = .systemBackground
        but.backgroundColor = UIColor(red: 33, green: 33, blue: 33)
        but.setTitleColor(.white, for: .normal)
        but.setTitle("Continue", for: .normal)
        return but
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isUserInteractionEnabled = false
        scroll.backgroundColor = UIColor(named: "Fon")
        return scroll
    }()
    
    var page:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Fon")
        view.addSubview(scrollView)
        view.addSubview(buttonB)
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
            scrollView.bottomAnchor.constraint(equalTo: buttonB.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            buttonB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            buttonB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonB.heightAnchor.constraint(equalToConstant: 55)
        ])
        view.layoutIfNeeded()
        configure()
        buttonB.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    private func configure() {
        let titles = ["Welcome", "Cosmic Quizzes", "Begin Your Cosmic Adventure"]
        let secondTitles = [
            "Dive into fascinating lessons about galaxies, stars, planets, and beyond. Our curated content ensures an out-of-this-world learning experience.",
            "Challenge your cosmic knowledge with interactive quizzes. Become a true astronomer!",
            "Tap 'Continue' to start your cosmic adventure!"
        ]

        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height - 50))
            scrollView.addSubview(pageView)

            // title, image
            let label = UILabel(frame: CGRect(x: 10, y: 40, width: pageView.frame.size.width - 20, height: 120))
            let secondlabel = UILabel(frame: CGRect(x: 10, y: 470, width: pageView.frame.size.width - 20, height: 200))
            let imageView = UIImageView(frame: CGRect(x: 30, y: 170, width: pageView.frame.size.width - 70, height: 330))

            
            label.textAlignment = .center
            label.numberOfLines = 2
            label.font = UIFont(name: "Futura-Bold", size: 32)
            label.text = titles[x]
            pageView.addSubview(label)

            secondlabel.numberOfLines = 5
            secondlabel.textColor = UIColor(named: "forLabelColor")
            secondlabel.textAlignment = .center
            secondlabel.font = UIFont(name: "Futura-Medium", size: 21)
            secondlabel.text = secondTitles[x]
            pageView.addSubview(secondlabel)

            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome\(x+1)")
            pageView.addSubview(imageView)
        }

        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }

    
    @objc func didTapButton(_ button: UIButton) {
        if page < 2 {
            page += 1
            let xOffset = CGFloat(page) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)

            if page == 2 {
                buttonB.setTitle("Get started", for: .normal)
            }
        } else {
            // Save the username before marking the user as not a new user
            if let userName = Core.shared.getUserName() {
                Core.shared.saveUserName(userName)
            }

            UIView.animate(withDuration: 0.5, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
                self.view.alpha = 0
            }) { (_) in
                Core.shared.setIsNotNewUser()
                self.dismiss(animated: false, completion: nil)
            }
        }
    }




    
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

