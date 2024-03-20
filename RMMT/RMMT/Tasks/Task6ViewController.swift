//
//  Task6ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 20.03.24.
//

import UIKit

final class Task6ViewController: UIViewController {
    /*
     Выведется ACB
     Потому главная очередь успеет продолжит выполнение своих задач AC,
     затем асинхронно на ней же вызовется B
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        print("A")

        DispatchQueue.main.async {
            print("B")
        }

        print("C")
    }
}
