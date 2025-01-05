//
//  InfoTableViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//

import UIKit
import Kingfisher

class InfoTableViewController: UITableViewController {

    let list = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
}

extension InfoTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        
        cell.imageview.kf.setImage(with: URL(string: list[row].photo_image))
        cell.titleLabel.text = list[row].title
        cell.subtitleLabel.text = list[row].subtitle
        cell.dateLabel.text = list[row].date.stringToDateFormat()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
