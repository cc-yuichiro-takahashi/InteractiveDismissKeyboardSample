//
//  ViewController.swift
//  KeyboardSample
//
//  Created by yuichiro_takahashi on 2022/03/14.
//

import UIKit

class ViewController: UIViewController {
    @IBAction private func navigateToChatButtonTapAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        viewController.modalPresentationStyle = .fullScreen

        present(viewController, animated: true, completion: nil)
    }
}


