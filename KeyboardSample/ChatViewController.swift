//
//  ChatViewController.swift
//  KeyboardSample
//
//  Created by yuichiro_takahashi on 2022/03/14.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet private weak var inputFieldContainerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var containerViewBottomConstraint: NSLayoutConstraint!

    private let dummyMessages = [
        Message(text: "test", userName: "testUser", postDate: "2022/12/23")
    ]

    private var bottomSareAreaHeight: CGFloat{
        let scenes = UIApplication.shared.connectedScenes
        return (scenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.bottom ?? 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        observeKeyboardNotification()
    }

    @IBAction private func postButtonTapAction(_ sender: UIButton) {
        textView.endEditing(true)
        textView.text = ""
    }
}

private extension ChatViewController {
    func configureTableView() {
        let nib = UINib(nibName: MessageCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MessageCell.reuseIdentifier)

        // TableView を反転させてセルを下詰めする
        tableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)

        tableView.dataSource = self
    }

    func observeKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main,
                                               using: { [weak self] notification in
            let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.2
            self?.keyboardWillShow(keyboardFrame: keyboardFrame, duration: duration)
        })

        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil,
                                       queue: .main,
                                       using: { [weak self] notification in
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.2
            self?.keyboardWillHide(duration: duration)
        })
    }

    func keyboardWillShow(keyboardFrame: CGRect, duration: Double) {
        let keyboardHeight = keyboardFrame.size.height

        containerViewBottomConstraint.constant = -(keyboardHeight - bottomSareAreaHeight)

        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
        })
    }

    func keyboardWillHide(duration: Double) {
        containerViewBottomConstraint.constant = 0

        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseIdentifier) as! MessageCell
        cell.bind(message: dummyMessages[indexPath.row])
        // TableView に合わせて Cell も反転させる
        cell.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)

        return cell
    }
}
