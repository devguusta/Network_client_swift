//
//  HomeScreen.swift
//  movies_app
//
//  Created by Premiersoft on 24/08/23.
//

import UIKit

class SplashScreen: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
        self.configConstraints()
        self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var  streamFlixLogo = {
        let imageLogo: UIImageView = UIImageView()
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = UIImage(named: "streamflix_logo")
        
        return imageLogo
    }()
    
    
    private func addComponents(){
            addSubview(streamFlixLogo)
    }
    
    
    private func configConstraints(){
        NSLayoutConstraint.activate([
            streamFlixLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 140),
            streamFlixLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
           
        
        ])
    }

}
