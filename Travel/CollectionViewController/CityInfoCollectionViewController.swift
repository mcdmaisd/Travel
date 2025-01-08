//
//  CityInfoCollectionViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-08.
//

import UIKit

class CityInfoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var cityCollectionView: UICollectionView!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    private let list = CityInfo().city
    
    private lazy var filteredList = list {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        configureSegmentControl()
    }
    
    private func initCollectionView() {
        let id = CityInfoCollectionViewCell.id
        let xib = UINib(nibName: id, bundle: nil)
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        cityCollectionView.register(xib, forCellWithReuseIdentifier: id)
        
        setCollectionView()
    }
    
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let topIndexPath = IndexPath(row: 0, section: 0)
        
        filteredList = makeFilteredList(index)
        cityCollectionView.scrollToItem(at: topIndexPath, at: .top, animated: true)
    }
    
    private func makeFilteredList(_ index: Int) -> [City] {
        if index == 0 {
            return list
        } else if index == 1 {
            return list.filter { $0.domestic_travel == true }
        } else {
            return list.filter { $0.domestic_travel == false }
        }
    }
    
    private func configureSegmentControl() {
        for (i, title) in TravelConstants.segmentTitles.enumerated() {
            segmentControl.setTitle(title, forSegmentAt: i)
        }
        
        segmentControl.selectedSegmentIndex = 0
    }

    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let numberOfItemsInLine: CGFloat = 2
        let inset: CGFloat = 10
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - (numberOfItemsInLine + 1) * inset) / numberOfItemsInLine

        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumLineSpacing = inset
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
        
        cityCollectionView.collectionViewLayout = layout
    }
}

extension CityInfoCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityInfoCollectionViewCell.id, for: indexPath) as! CityInfoCollectionViewCell
        
        cell.configureData(filteredList[row])
        
        return cell
    }
}
