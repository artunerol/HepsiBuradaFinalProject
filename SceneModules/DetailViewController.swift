//
//  DetailViewController.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties
    
    public static var shared = DetailViewController()
    
    private var containverView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 14
        
        temp.layer.shadowOffset = CGSize(width: 1, height: 7)
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOpacity = 0.5
        
        temp.backgroundColor = ViewBackGroundTheme.darkBackground.value //Giving custom gradient Image as Color for background
        
        return temp
    }()
    
    public var mainTitle: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.layer.masksToBounds = true
        
        temp.textAlignment = .center
        temp.textColor = .white
        temp.font = TextFonts.title(14).value
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        
        temp.layoutIfNeeded()
        
        return temp
    }()
    
    public var subTitle: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.layer.masksToBounds = true
        
        temp.textAlignment = .center
        temp.textColor = .white
        temp.font = TextFonts.subTitle(14).value
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        
        temp.layoutIfNeeded()
        
        return temp
    }()
    
    public var releaseDate: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.layer.masksToBounds = true
        
        temp.textAlignment = .center
        temp.textColor = .white
        temp.font = TextFonts.subTitle(11).value
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        
        temp.layoutIfNeeded()
        
        return temp
    }()
    
    public var imageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 14
        temp.layer.masksToBounds = true
        
        return temp
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCellComponentsConstraints()
    }
    
    //MARK: - Private funcs
    
    private func setupCellComponentsConstraints() {
        view.addSubview(containverView)
        containverView.addSubview(mainTitle)
        containverView.addSubview(imageView)
        containverView.addSubview(subTitle)
        containverView.addSubview(releaseDate)
        
        NSLayoutConstraint.activate([
            containverView.topAnchor.constraint(equalTo: view.topAnchor),
            containverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: containverView.topAnchor,constant: 5),
            mainTitle.trailingAnchor.constraint(equalTo: containverView.trailingAnchor,constant: -10), //Not giving a height constraint to label in order to increase its height if the text is too long
            mainTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            mainTitle.bottomAnchor.constraint(lessThanOrEqualTo: containverView.centerYAnchor), //Setting Title to not to be bigger than the centerY of the container
            
            subTitle.bottomAnchor.constraint(lessThanOrEqualTo: containverView.bottomAnchor,constant: -5),
            subTitle.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            subTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 3),
            
            releaseDate.bottomAnchor.constraint(lessThanOrEqualTo: containverView.bottomAnchor,constant: -5),
            releaseDate.trailingAnchor.constraint(equalTo: containverView.trailingAnchor,constant: -10),
            
            
            imageView.centerYAnchor.constraint(equalTo: containverView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: containverView.leadingAnchor,constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    
}
