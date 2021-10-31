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
    
    private lazy var containverView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = ViewBackGroundTheme.darkBackground.value //Giving custom gradient Image as Color for background
        
        return temp
    }()
    
    public lazy var mainTitle: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.layer.masksToBounds = true
        
        temp.textAlignment = .center
        temp.textColor = .white
        temp.font = TextFonts.title(20).value
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        
        temp.layoutIfNeeded()
        
        return temp
    }()
    
    private lazy var releaseDate: UILabel = {
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
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(systemName: "person")
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 14
        temp.layer.masksToBounds = true
        
        return temp
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupCellComponentsConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
        containverView.addSubview(releaseDate)
        
        NSLayoutConstraint.activate([
            
            containverView.topAnchor.constraint(equalTo: view.topAnchor),
            containverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            releaseDate.bottomAnchor.constraint(lessThanOrEqualTo: containverView.bottomAnchor,constant: -5),
            releaseDate.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            releaseDate.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 3),
            
            imageView.centerYAnchor.constraint(equalTo: containverView.centerYAnchor,constant: -20),
            imageView.centerXAnchor.constraint(equalTo: containverView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            mainTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mainTitle.centerXAnchor.constraint(equalTo: containverView.centerXAnchor),
            mainTitle.leadingAnchor.constraint(lessThanOrEqualTo: containverView.leadingAnchor),
            mainTitle.trailingAnchor.constraint(lessThanOrEqualTo: containverView.trailingAnchor)
            
        ])
    }
}

extension DetailViewController: DidSelectCellProtocol {
    
    func setTitle(title: String) {
        self.mainTitle.text = title
    }
    
    func setReleaseDate(date: String) {
        let releaseDateFormatted = DateFormatterHandler.shared.getFormattedDate(with: date)
        releaseDate.text = releaseDateFormatted
    }
    
    func setImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] imageData, urlResponse, error in
            if error == nil {
                guard let imageDataUnwrapped = imageData else { return }
                guard let image = UIImage(data: imageDataUnwrapped) else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }.resume()
    }
    
}
