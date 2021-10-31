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
    
    weak var delegate: DidSelectCellProtocol?
    
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
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfigurations()
    }
    
    //MARK: - Private funcs
    
    /// Setup Configutarions of searchBar and CollectionView
    private func setupViewConfigurations() {
        setupCollectionViewConfigurations()
        setupSearchBarConfigurations()
        setUpSegmentedControlConfigurations()
    }
    
    private func setupCollectionViewConfigurations() {
        mainResultCollectionView.delegate = self
        mainResultCollectionView.dataSource = self
        mainResultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        mainResultCollectionView.backgroundColor = ViewBackGroundTheme.lighterBackground.value
    }
    
    private func setupSearchBarConfigurations() {
        navigationBarSearchBar.delegate = self
        navigationBarSearchBar.backgroundColor = ViewBackGroundTheme.lighterBackground.value
        navigationItem.titleView = navigationBarSearchBar //Adding Search Bar to NavigationBar as TitleView
    }
    
    private func setUpSegmentedControlConfigurations() {
        
        SegmentedControlButton.backgroundColor = .gray
        SegmentedControlButton.selectedSegmentTintColor = .darkGray
        segmentedControlButtonBackground.backgroundColor = ViewBackGroundTheme.lighterBackground.value // setting background color for the UI below segmented button
    }
    
}

//MARK: - CollectionView Extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///Setting Cell For item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(with: apiDataArray[indexPath.row]) //Configuring Cell with APIData
        return cell
    }
    
//MARK: - Data pass to DetailVC
    
    ///Passing Data to detailViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        delegate = vc
        delegate?.setTitle(title: apiDataArray[indexPath.row].trackName ?? "")
        delegate?.setImage(imageURL: apiDataArray[indexPath.row].artworkUrl100 ?? "")
        delegate?.setReleaseDate(date: apiDataArray[indexPath.row].releaseDate ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK: - Pagination
    
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
    
//MARK: - CollectionView Frame and size
    /// Setting Size For Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 15, height: 100)
    }
    
    ///Setting Edge Insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiDataArray.count
    }
    
}

//MARK: - SearchBar+Extension
extension ViewController: UISearchBarDelegate {
    
    ///When searchButton clicked(search Button is "Enter" in our case) get the APIData
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        apiDataArray.removeAll()
        
        let searchedItemName = navigationBarSearchBar.text ?? ""
        
        let selectedSegmentIndex = SegmentedControlButton.selectedSegmentIndex
        guard let searchedItemType = SegmentedControlButton.titleForSegment(at: selectedSegmentIndex) else { return }
        
        if searchedItemName != "" {
            
            APIHandler.shared.getData(searchedItemType: searchedItemType, searchedItemName: searchedItemName, offset: apiDataArray.count) { [weak self] apiData in
                self?.apiDataArray.append(contentsOf: apiData.results) //setting APIData to an array of a Global Property
                DispatchQueue.main.async {
                    self?.mainResultCollectionView.reloadData()
                }
            }
        }
    }
}



