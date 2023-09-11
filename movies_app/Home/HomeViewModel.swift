//
//  HomeViewModel.swift
//  movies_app
//
//  Created by Premiersoft on 24/08/23.
//

import Foundation
protocol HomeViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class HomeViewModel{
    
    private var service: HomeServices = HomeServices()
    private var users: [User] = []
    private weak var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func getUsers(){
        service.fetchRequest { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let success):
                self.users = success
                print(self.users)
                self.delegate?.success()
            case .failure(let failure):
                self.delegate?.error(message: failure.errorDescription ?? "")
            }
            
        }
        
    }
    
    public var numberOfRowsInSection: Int {
        return users.count
    }
    
    
    public func loadCurrentPerson(indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }
    
}
