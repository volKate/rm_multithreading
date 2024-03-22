//
//  Task2ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 20.03.24.
//

import UIKit

final class Task2ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let asyncWorker = AsyncWorker()
        
        asyncWorker.doJobs(postNumbers: 1, 2, 3, 4, 5) { posts in
            print(Thread.current)
            print(posts.map { $0.id })
        }
    }
    
    
    class AsyncWorker {
        private let dispatchGroup = DispatchGroup()

        func doJobs(postNumbers: Int..., completion: @escaping ([Post]) -> Void) {
            var posts = [Post]()
            
            for i in postNumbers {
                // Добавляем в группу
                dispatchGroup.enter()
                URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/\(i)")!)) { data, response, error in
                    guard let data = data else {
                        return
                    }
                    if let post = try? JSONDecoder().decode(Post.self, from: data) {
                        posts.append(post)
                        // Сообщаем о выходе из группы
                        self.dispatchGroup.leave()
                    }
                }
                .resume()
            }
            
            // подписываемся на завершение всех асинхронных
            // задач в группе
            dispatchGroup.notify(queue: .main) {
                completion(posts)
            }
        }
    }
    
    struct Post: Codable {
        var userId: Int
        var id: Int
        var title: String
        var completed: Bool
    }
}
