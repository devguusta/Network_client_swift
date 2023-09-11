//
//  HomeViewController.swift
//  movies_app
//
//  Created by Premiersoft on 24/08/23.
//

import UIKit

extension HomeViewController: HomeViewModelProtocol {
    func success() {
        print("deu boa")
    }
    
    func error(message: String) {
        print(message)
    }
    
    
}

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel = HomeViewModel()
    var homeScreen: HomeScreen?

    override func viewDidLoad() {
        super.viewDidLoad()

        homeScreen = HomeScreen()
        view.backgroundColor = .red
        viewModel.delegate(delegate: self)
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getUsers()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
