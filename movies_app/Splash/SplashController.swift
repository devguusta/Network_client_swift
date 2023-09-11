//
//  ViewController.swift
//  movies_app
//
//  Created by Premiersoft on 24/08/23.
//

import UIKit

class SplashController: UIViewController {
     var splashPage: SplashScreen?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        splashPage = SplashScreen()
        view = splashPage
        loadNextVC()
        navigationController?.delegate = self
        
       
    }
    
    private func loadNextVC() {
       
 let   homeViewController: HomeViewController = HomeViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}


extension SplashController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Verifique se a view controller atual é a que você deseja bloquear o botão de voltar
        if viewController == self {
            // Desabilite o botão de voltar
            viewController.navigationItem.setHidesBackButton(true, animated: false)
        } else {
            // Habilitar o botão de voltar para outras view controllers
            viewController.navigationItem.setHidesBackButton(false, animated: false)
        }
    }
}
