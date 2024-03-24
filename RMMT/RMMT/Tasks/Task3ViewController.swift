//
//  Task3ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 24.03.24.
//

import UIKit

final class Task3ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        func randomD6() async -> Int {
            Int.random(in: 1...6)
        }

        Task {
            let result =  await randomD6()
            print(result)
        }
    }
}
