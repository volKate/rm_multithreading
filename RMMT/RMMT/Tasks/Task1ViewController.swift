//
//  Task1ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 20.03.24.
//

import UIKit

final class Task1ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let phrasesService = PhrasesService()
        let phrasesServiceActor = PhrasesServiceActor()

        // 1
        DispatchQueue.concurrentPerform(iterations: 10) { i in
            phrasesService.addPhrase("Phrase \(i)")
            /*
             Я пока не разобралась как нормально созватать контекст
             Тем более, что пока "не трогаем" async/await
             */
            Task {
                await phrasesServiceActor.addPhrase("Phrase \(i)")
            }
        }

        // Даем потокам время на завершение работы
        Thread.sleep(forTimeInterval: 1)

        // Выводим результат
        print("semaphor", phrasesService.phrases)
        Task {
            print("actor", await phrasesServiceActor.phrases)
        }
    }

    class PhrasesService {
        private let semaphore = DispatchSemaphore(value: 1)
        var phrases: [String] = []

        func addPhrase(_ phrase: String) {
            // 2
            /*
             С помощью семафора разрешаем только одному потоку
             одновременно заходить и мутировать
             */
            semaphore.wait()
            phrases.append(phrase)
            semaphore.signal()
        }
    }

    actor PhrasesServiceActor {
        var phrases: [String] = []

        func addPhrase(_ phrase: String) {
            print(Thread.current)
            phrases.append(phrase)
        }
    }
}
