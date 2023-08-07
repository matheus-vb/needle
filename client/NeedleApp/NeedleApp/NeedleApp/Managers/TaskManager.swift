//
//  TaskManager.swift
//  NeedleApp
//
//  Created by jpcm2 on 07/08/23.
//

import Foundation
import Combine

class TaskManager: ObservableObject{
    static let shared = TaskManager()
    
    private init() {}
    
    @Published var userTasks: [TaskModel]?
    @Published var currError: NetworkingManager.NetworkingError?
    @Published var errorCount: Int = 0
    var signInSubscription: AnyCancellable?

    func createTask(dto: CreateTaskDTO){
        guard let url = URL(string: Bundle.baseURL + "task/create") else {return}
                
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        print(url)
        print(parameters)
        signInSubscription = NetworkingManager.post(url: url, body: jsonData)
            .decode(type: TaskResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    print("ERROR -> ", error)
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedUser) in
                print("---->   Task criada com sucesso!")
                self?.userTasks = returnedUser.data
                print(self?.userTasks)
                self?.signInSubscription?.cancel()
            })
    }
}
