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
    
    private lazy var containverView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 14

        temp.layer.shadowOffset = CGSize(width: 1, height: 7)
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOpacity = 0.5
        
        temp.backgroundColor = ViewBackGroundTheme.darkBackground.value //Giving custom gradient Image as Color for background
        
        return temp
    }()
    
    private lazy var title: UILabel = {
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
    
    private lazy var subTitle: UILabel = {
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
    
    private lazy var releaseDate: UILabel = {
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
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 14
        temp.layer.masksToBounds = true
        
        return temp
    }()
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellComponentsConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private funcs
    
    private func setupCellComponentsConstraints() {
        addSubview(containverView)
        containverView.addSubview(title)
        containverView.addSubview(imageView)
        containverView.addSubview(subTitle)
        containverView.addSubview(releaseDate)
        
        NSLayoutConstraint.activate([
            containverView.topAnchor.constraint(equalTo: topAnchor),
            containverView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containverView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            title.topAnchor.constraint(equalTo: containverView.topAnchor,constant: 5),
            title.trailingAnchor.constraint(equalTo: containverView.trailingAnchor,constant: -10), //Not giving a height constraint to label in order to increase its height if the text is too long
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            title.bottomAnchor.constraint(lessThanOrEqualTo: containverView.centerYAnchor), //Setting Title to not to be bigger than the centerY of the container
            
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
    //MARK: - Public Funcs
    ///Configuring cell with the data from API
    func configureCell(with apiData: APIResultKeys) {
        self.imageView.image = nil //For Reusing cell operations, making the image nil
        self.title.text = nil
        guard let url = URL(string: apiData.artworkUrl100 ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, dataResponse, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
                self.title.text = apiData.trackName
                self.subTitle.text = "\(apiData.collectionPrice ?? 0)$"
                self.releaseDate.text = self.getFormattedDate(with: apiData.releaseDate ?? "")
            }
        }.resume()
    }
    
    ///DateFormatting Function
    private func getFormattedDate(with apiDate: String) -> String{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"

            let date: Date? = dateFormatterGet.date(from: apiDate)
            return dateFormatterPrint.string(from: date!);
        }
}
