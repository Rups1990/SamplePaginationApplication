//
//  TableViewCell.swift
//  SamplePaginationApplication
//
//  Created by Rubha Selvaraj on 29/05/24.
//

import UIKit

final class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    var model: UserInfo? = nil {
        didSet {
            if let id = model?.id {
                let stringId = String(id)
                userIdLabel.text = stringId
            }
            titleLabel.text = model?.title
            bodyLabel.text = model?.body
        }
    }
}
