//
//  DetailViewController.swift
//  SamplePaginationApplication
//
//  Created by Rubha Selvaraj on 30/05/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var userIdLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    var model: UserInfo!
    
    init?(coder: NSCoder, model: UserInfo) {
        super.init(coder: coder)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        if let id = model?.id {
            idLabel.text = "\(id)"
        }
        if let id = model?.userId {
            userIdLabel.text = "\(id)"
        }
        titleLabel.text = model?.title
        bodyLabel.text = model?.body
    }
}
