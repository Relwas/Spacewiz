import UIKit

@available(iOS 13.0, *)
class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView: UITableView!
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "Fon1")
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        view.backgroundColor = UIColor(named: "Fon")
        view.addSubview(headerLabel)

        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(named: "Fon")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = getItemText(for: indexPath.row)
        cell.textLabel?.textColor = UIColor(named: "Fon1")
        cell.backgroundColor = UIColor(named: "Fon")
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.0
    }

    private func getItemText(for row: Int) -> String {
        switch row {
        case 0:
            return "Edit Name"
        case 1:
            return "About App"
        case 2:
            return "Share App"
        case 3:
            return "Rate App"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let alertController = UIAlertController(title: "Edit Name", message: "Enter your new name", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "New Name"
            }

            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                if let newName = alertController.textFields?.first?.text {
                    Core.shared.saveUserName(newName)
                    self?.tableView.reloadData()
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)

        case 1:
            let aboutViewController = AboutAppViewController()
            aboutViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(aboutViewController, animated: true)

        case 2:
            shareApp()

        case 3:
            rateApp()

        default:
            break
        }
    }

    @objc private func shareApp() {
        let appName = "Your App Name"
        let appDescription = "Discover amazing features of Your App!"
        
        guard let appURL = URL(string: "https://t.me/relwas") else {
            return
        }

        let shareText = "Check out \(appName): \(appDescription) \n\(appURL)"
        let shareItems: [Any] = [shareText, appURL]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        present(activityViewController, animated: true, completion: nil)
    }

    @objc private func rateApp() {
        guard let appStoreURL = URL(string: "https://t.me/relwas") else {
            return
        }

        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }
}
