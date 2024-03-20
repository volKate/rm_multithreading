//
//  Task7ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 20.03.24.
//

import UIKit

final class Task7ViewController: UIViewController {
    var lock = NSLock()
    private lazy var name = "I love RM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async { [weak self] in
            self?.lock.lock()
            print(self?.name ?? "") // Считываем имя из global
            print(Thread.current)
            self?.lock.unlock()
        }
        
        self.lock.lock()
        print(self.name) // Считываем имя из main
        self.lock.unlock()
    }
}

/*
 Проблема одновременного чтения одного участка памяти
 В данном случае еще и при одновременном обращении
 к lazy var может происходить ее многократная инициализация
 */
