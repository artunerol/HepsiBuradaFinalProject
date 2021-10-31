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
    @IBOutlet weak var segmentedControlButtonBackground: UIView!
    
    //MARK: - Properties
    
    private lazy var navigationBarSearchBar: UISearchBar = {
        let temp = UISearchBar()
        temp.backgroundColor = ViewBackGroundTheme.lighterBackground.value
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.sizeToFit()
        temp.layoutIfNeeded()
        temp.placeholder = "Search Here"
        temp.searchTextField.font = TextFonts.title(17).value
        temp.searchTextField.textColor = .black
        temp.searchTextField.backgroundColor = .white
        
        return temp
    }()
    
    private var apiDataArray = [APIResultKeys]()
    private var viewModel : MainViewControllerViewModel!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfigurations()
        settingColorsForUIViews()
    }
    
    //MARK: - Segue
    
    //MARK: - Private funcs
    
    /// Setup Configutarions of searchBar and CollectionView
    private func setupViewConfigurations() {
        
        navigationItem.titleView = navigationBarSearchBar //Adding Search Bar to NavigationBar as TitleView
        
        navigationBarSearchBar.delegate = self
        
        mainResultCollectionView.delegate = self
        mainResultCollectionView.dataSource = self
        
        mainResultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
    ///COLORS
    private func settingColorsForUIViews() {
        navigationBarSearchBar.backgroundColor = ViewBackGroundTheme.lighterBackground.value
        
        mainResultCollectionView.backgroundColor = ViewBackGroundTheme.lighterBackground.value
        
        segmentedControlButtonBackground.backgroundColor = ViewBackGroundTheme.lighterBackground.value // setting background color for the UI below segmented button
        SegmentedControlButton.backgroundColor = .gray
        SegmentedControlButton.selectedSegmentTintColor = .darkGray
    }
}

//MARK: - CollectionView Extension
///Setting Numbers of item in section
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiDataArray.count
    }
    
    ///Setting Cell For item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(with: apiDataArray[indexPath.row]) //Configuring Cell with APIData
        return cell
    }
    
    ///Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Whenever the last cell of the collectionview has loaded, get new data From API
        if indexPath.row == apiDataArray.count - 1 {
            
            let selectedSegmentIndex = SegmentedControlButton.selectedSegmentIndex
            guard let selectedSegmentTitle = SegmentedControlButton.titleForSegment(at: selectedSegmentIndex) else { return }
            
            //Getting Data from api with the current offset
            APIHandler.shared.getData(searchedItemType: selectedSegmentTitle, searchedItemName: navigationBarSearchBar.text!, offset: apiDataArray.count - 1) { [weak self] apiData in
                
                self?.apiDataArray.append(contentsOf: apiData.results)
                
                DispatchQueue.main.async {
                    self?.mainResultCollectionView.reloadData() //Reloading collectionView when got the data from API
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DetailViewController.shared.mainTitle.text = apiDataArray[indexPath.row].trackName
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    /// Setting Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 15, height: 100)
    }
    
    ///Setting Edge Insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return edgeInsets
    }
    
}

//MARK: - SearchBar+Extension
extension ViewController: UISearchBarDelegate {
    
    ///When searchButton clicked(search Button is "Enter" in our case) get the APIData
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //
        //        if navigationBarSearchBar.text != nil || navigationBarSearchBar.text != "" {
        //
        //            let selectedSegmentIndex = SegmentedControlButton.selectedSegmentIndex
        //            guard let searchedItemType = SegmentedControlButton.titleForSegment(at: selectedSegmentIndex) else { return }
        //
        //            viewModel = MainViewControllerViewModel(searchedItemType: searchedItemType , searchedItemName: navigationBarSearchBar.text!)
        //            viewModel.apiDataArray.removeAll() //Removing Inside The array to append new search items
        //            viewModel.getAPIData { complete in
        //                if complete {
        //                    DispatchQueue.main.async {
        //                        self.mainResultCollectionView.reloadData()
        //                    }
        //                }
        //            }
        //        }
        
        if navigationBarSearchBar.text != nil || navigationBarSearchBar.text != "" {
            
            let selectedSegmentIndex = SegmentedControlButton.selectedSegmentIndex
            guard let searchedItemType = SegmentedControlButton.titleForSegment(at: selectedSegmentIndex) else { return }
            
            APIHandler.shared.getData(searchedItemType: searchedItemType, searchedItemName: navigationBarSearchBar.text!, offset: apiDataArray.count, completion: { [weak self] apiData in //fetching data from API
                
                self?.apiDataArray.append(contentsOf: apiData.results) //setting APIData to an array of a Global Property
                
                DispatchQueue.main.async {
                    self?.mainResultCollectionView.reloadData() //Reloading collectionView when got the data from API
                }
                
            })
        }
    }
}



