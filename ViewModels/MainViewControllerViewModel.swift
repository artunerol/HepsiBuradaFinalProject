//
//  MainViewControllerViewModel.swift
//  HepsiBuradaFinalProject
//
//  Created by Artun Erol on 30.10.2021.
//

import UIKit

typealias BoolBlock = (Bool) -> Void

class MainViewControllerViewModel: NSObject {
    
    public var searchButtonClicked : BoolBlock?
    
    public var apiDataArray = [APIResultKeys]()
    
    private(set) var searchedItemType: String
    private(set) var searchedItemName: String
    
    init(searchedItemType: String, searchedItemName: String) {
        self.searchedItemType = searchedItemType
        self.searchedItemName = searchedItemName
    }
    
    //MARK: - Funcs
    func getAPIData(with completion: @escaping (Bool) -> Void) {
        APIHandler.shared.getData(searchedItemType: searchedItemType, searchedItemName: searchedItemName, offset: apiDataArray.count, completion: { [weak self] apiData in //fetching data from API
            
            self?.apiDataArray.append(contentsOf: apiData.results) //setting APIData to an array of a Global Property
            completion(true)
        })
    }
}

//MARK: - CollectionView Extension
///Setting Numbers of item in section
extension MainViewControllerViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiDataArray.count
    }
    
    ///Setting Cell For item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(with: apiDataArray[indexPath.row]) //Configuring Cell with APIData
        
        return cell
    }
    
//    ///Pagination
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        //Whenever the last cell of the collectionview has loaded, get new data From API
//        if indexPath.row == apiDataArray.count - 1 {
//
//            let selectedSegmentIndex = SegmentedControlButton.selectedSegmentIndex
//            guard let selectedSegmentTitle = SegmentedControlButton.titleForSegment(at: selectedSegmentIndex) else { return }
//
//            //Getting Data from api with the current offset
//            APIHandler.shared.getData(searchedItemType: selectedSegmentTitle, searchedItemName: navigationBarSearchBar.text!, offset: apiDataArray.count - 1) { [weak self] apiData in
//
//                self?.apiDataArray.append(contentsOf: apiData.results)
//
//                DispatchQueue.main.async {
//                    self?.mainResultCollectionView.reloadData() //Reloading collectionView when got the data from API
//                }
//            }
//        }
//    }
    
    /// Setting Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ViewController().view.frame.width/2 - 15, height: 100)
    }
    
    ///Setting Edge Insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return edgeInsets
    }
}
