//
//  MainViewController.swift
//  SpaceWiz1
//
//  Created by relwas on 02/12/23.
//

import UIKit

@available(iOS 13.0, *)
class MainViewController: UIViewController {

    var topics: [Topic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Fon")

        if let path = Bundle.main.path(forResource: "topics", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let topicsResponse = try? JSONDecoder().decode(TopicsResponse.self, from: data) {
            topics = topicsResponse.topics
        }

        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

    }

    @objc func startQuiz() {
        let quizViewController = QuizViewController()
        navigationController?.pushViewController(quizViewController, animated: true)
    }
}

@available(iOS 13.0, *)
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let topic = topics[indexPath.row]
        tableView.backgroundColor = UIColor(named: "Fon")

        // Set the text and font for the cell
        cell.textLabel?.text = topic.title
        cell.textLabel?.font = UIFont(name: "Futura-Medium", size: 20.0)
        cell.backgroundColor = UIColor(named: "Fon")

        return cell
    }
}

@available(iOS 13.0, *)
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedTopic = topics[indexPath.row]

        let detailsViewController = TopicDetailsViewController(topic: selectedTopic)
        detailsViewController.hidesBottomBarWhenPushed = true  // Hide the tab bar
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

@available(iOS 13.0, *)
class TopicDetailsViewController: UIViewController {

    private let topic: Topic

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Bold", size: 22.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 20.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(topic: Topic) {
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
        title = topic.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "Fon")

        // Add the scroll view to the view
        view.addSubview(scrollView)

        // Add content view to scroll view
        scrollView.addSubview(contentView)

        // Set constraints for the scroll view
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

        // Set constraints for the content view
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        // Add the title label to the content view
        contentView.addSubview(titleLabel)

        // Set constraints for the title label
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        // Add the text label to the content view
        contentView.addSubview(textLabel)

        // Set constraints for the text label
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -20).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true

        // Load JSON data and set content
        if let path = Bundle.main.path(forResource: "topics", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let topicsResponse = try? JSONDecoder().decode(TopicsResponse.self, from: data),
           let matchingTopic = topicsResponse.topics.first(where: { $0.title == topic.title }) {
            
            titleLabel.textAlignment = .center
            titleLabel.text = ""
            textLabel.textAlignment = .justified
            textLabel.text = matchingTopic.text
        }
    }
}
