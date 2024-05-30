//
//  ViewController.swift
//  SamplePaginationApplication
//
//  Created by Rubha Selvaraj on 29/05/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableview: UITableView!

    private let reuseIdentifier = "UserInfoTableViewCell"
    private var userContent: [UserInfo] = []
    private let pageHandler = PaginationHandler()
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    private var needData = false {
        didSet {
            if needData {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    self?.fetchUserInfo()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSpinnerView()
        spinner.startAnimating()
        
        tableview.register(UINib(nibName: "UserInfoTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        needData = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        userContent.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UserInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserInfoTableViewCell
        let currentUserInfo = userContent[indexPath.row]
        cell.model = currentUserInfo
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last,
            lastIndexPath.row == userContent.count - 1 {
            needData = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUserInfo = userContent[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "detail", creator: { coder in
            return DetailViewController(coder: coder, model: currentUserInfo)
        }) 
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
    
}

extension ViewController {
    
    private func addSpinnerView() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}

extension ViewController {
    
    private func fetchUserInfo() {
        pageHandler.fetchUserInfo(completion: { [weak self] contents in
            guard let userInfo = contents, !userInfo.isEmpty else { return } // add error state if possible
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.userContent.append(contentsOf: userInfo)
                self?.tableview.reloadData()
            }
        })
    }
}
