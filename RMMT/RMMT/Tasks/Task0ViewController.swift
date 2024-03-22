//
//  Task0ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 18.03.24.
//

import UIKit

final class Task0ViewController: UIViewController {
    private let service = DataService()
    private let queue = DispatchQueue(label: "queue")
    override func viewDidLoad() {
        super.viewDidLoad()
        runTask()
    }

    private func runTask() {
        DispatchQueue.global(qos: .background).async {
            self.queue.async {
                let value = self.service.calculateSum(100)
                sleep(1)
                print(value, Thread.current)
            }
        }

        DispatchQueue.global(qos: .background).async {
            self.queue.async {
                let value = self.service.calculateSum(100)
                sleep(2)
                print(value, Thread.current)
            }
        }

        DispatchQueue.global(qos: .background).async {
            self.queue.async {
                let value = self.service.calculateSum(100)
                print(value, Thread.current)
            }
        }

        DispatchQueue.global(qos: .background).async {
            self.queue.async {
                let value = self.service.calculateSum(100)
                print(value, Thread.current)
            }
        }

        DispatchQueue.global(qos: .background).async {
            self.queue.async {
                let value = self.service.calculateSum(100)
                sleep(3)
                print(value, Thread.current)
            }
        }
    }
}

class DataService {
    var result = 0

    func calculateSum(_ num: Int) -> Int {
        result += num
        return result
    }
}
