//
//  ResultCollectionViewCell.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    //MARK: - Identifier
    static public let identifier = "ResultCollectionViewCell"
    
    //MARK: - Subviews
    private lazy var title: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textAlignment = .center
        
        temp.text = "This is title"
        return temp
    }()
    
    private lazy var image: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(systemName: "person")!
        return temp
    }()
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellComponentsConstraints()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private funcs
    
   private func setupCellComponentsConstraints() {
        addSubview(image)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
