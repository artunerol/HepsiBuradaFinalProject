//
//  ViewController.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var mainResultCollectionView: UICollectionView!
    @IBOutlet weak var SegmentedControlButton: UISegmentedControl!
    
    //MARK: - Properties
    
    private lazy var navigationBarSearchBar: UISearchBar = {
        let temp = UISearchBar()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.sizeToFit()
        temp.layoutIfNeeded()
        temp.placeholder = "Search Here"
        
        return temp
    }()
    
    private var apiData : [APIResultKeys]?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navigationBarSearchBar //Adding Search Bar to NavigationBar as TitleView
        setupCollectionView()
    }
    
    //MARK: - Private funcs
    
    /// CollectionView Configurations
    private func setupCollectionView() {
        navigationBarSearchBar.delegate = self
        mainResultCollectionView.delegate = self
        mainResultCollectionView.dataSource = self
        mainResultCollectionView.backgroundColor = .cyan
        mainResultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
}

//MARK: - CollectionView Extension
///Setting Numbers of item in section
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    ///Setting Cell For item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    /// Setting Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 15, height: 150)
    }
    ///Setting Edge Insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return edgeInsets
    }
}

//MARK: - SearchBar+Extension
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let selectedSegmentIndex = SegmentedControlButton.selectedSegmentIndex
        guard let selectedSegmentTitle = SegmentedControlButton.titleForSegment(at: selectedSegmentIndex) else { return }
        
        if navigationBarSearchBar.text != nil || navigationBarSearchBar.text != "" {
            APIHandler.shared.getData(productType: selectedSegmentTitle.lowercased(), searchedProductName: navigationBarSearchBar.text!.lowercased()) { apiData in
                self.apiData = apiData.results
                print("self.apiData is \(self.apiData)")
            }
        }
    }
}



