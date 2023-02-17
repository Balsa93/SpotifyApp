//
//  ProfileViewController.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    private var models = [String]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        
        setUpTable()
        fetchProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Private
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure:
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
    }
    
    private func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else { return }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 1.5))
        let imageSize: CGFloat = headerView.height / 2
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        imageView.sd_setImage(with: url)
        headerView.addSubview(imageView)
        
        tableView.tableHeaderView = headerView
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.textColor = .secondaryLabel
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = model
        cell.selectionStyle = .none
        return cell
    }
}
