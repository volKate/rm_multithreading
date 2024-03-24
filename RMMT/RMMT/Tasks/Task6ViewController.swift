//
//  Task6ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 24.03.24.
//

import UIKit

final class Task6ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await printMessage()
        }
    }

    func printMessage() async {
        let string = await withTaskGroup(of: String.self) { group -> String in
            // тут добавляем строки в группу
            for message in ["Hello", "My", "Road", "Map", "Group"] {
                group.addTask {
                    message
                }
            }
            var collected = [String]()

            for await value in group {
                collected.append(value)
            }

            return collected.joined(separator: " ")
        }

        print(string)
    }
}
