//
//  MessageCell.swift
//  KeyboardSample
//
//  Created by yuichiro_takahashi on 2022/03/14.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!

    static let reuseIdentifier = "MessageCell"

    func bind(message: Message) {
        messageLabel.text = message.text
        postDateLabel.text = message.postDate
        userNameLabel.text = message.userName
    }
}
