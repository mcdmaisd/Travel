//
//  CityTableViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit
import Kingfisher

class CityTableViewController: UITableViewController {

    private var list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        list[sender.tag].like?.toggle()
    }
    
    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationBar(_ ad: Bool, _ vc: UIViewController) {
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(back))
        let image = ad
            ? UIImage(systemName: TravelConstants.cancelImage)
            : UIImage(systemName: TravelConstants.backImage)

        backBarButtonItem.tintColor = .black
        backBarButtonItem.image = image
        vc.navigationItem.leftBarButtonItem = backBarButtonItem
    }
}

extension CityTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let isAD = list[row].ad
        let id = isAD ? AdTableViewCell.id : CityTableViewCell.id
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
                
        if isAD {
            (cell as! AdTableViewCell).configureData(list[row])
        } else {
            (cell as! CityTableViewCell).configureData(list[row], row)
            (cell as! CityTableViewCell).likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        TravelConstants.cityCellEstimatedHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let isAD = list[row].ad
        let id = isAD ? AdDetailViewController.id : CityDetailViewController.id
        let vc = isAD
            ? storyboard?.instantiateViewController(withIdentifier: id) as! AdDetailViewController
            : storyboard?.instantiateViewController(withIdentifier: id) as! CityDetailViewController
        
        if isAD {
            (vc as! AdDetailViewController).adMessage = list[row].title
        } else {
            (vc as! CityDetailViewController).info = list[row]
        }
        
        configureNavigationBar(isAD, vc)
        navigationController?.pushViewController(vc, animated: true)
    }
}
