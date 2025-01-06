//
//  CityInfoTableViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-06.
//

import UIKit

class CityInfoTableViewController: UITableViewController {
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var segmentControl: UISegmentedControl!
    
    private let list = CityInfo().city
    
    private lazy var filteredList = list {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        configureSegmentControl()
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
    
    @IBAction private func searchKeyword(_ sender: UITextField) {
        let text = sender.text?.replacingOccurrences(of: " ", with: "") ?? ""
        textField.text = text
        
        let index = segmentControl.selectedSegmentIndex
        let list = makeFilteredList(index)
        
        if text.isEmpty {
            if list == filteredList { return }
            else { filteredList = list }
        } else {
            filteredList = list.filter {
                $0.city_name == text ||
                $0.city_english_name.caseInsensitiveCompare(text) == .orderedSame ||
                $0.city_explain.components(separatedBy: ", ").contains(text)
            }
        }
    }
    
    @IBAction private func segmentControlTapped(_ sender: UISegmentedControl) {
        textField.text?.removeAll()
        let index = sender.selectedSegmentIndex
        filteredList = makeFilteredList(index)
    }
    
    private func configureSegmentControl() {
        for (i, title) in TravelConstants.segmentTitles.enumerated() {
            segmentControl.setTitle(title, forSegmentAt: i)
        }
        
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func initTableView() {
        let safeArea = self.view.safeAreaLayoutGuide
        let screenWidth = safeArea.layoutFrame.width
        let id = CityInfoTableViewCell.id
        let nib = UINib(nibName: id, bundle: nil)
        
        tableView.rowHeight = screenWidth / 2
        tableView.separatorStyle = .none
        tableView.register(nib, forCellReuseIdentifier: id)
    }
}

extension CityInfoTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let text = textField.text!
        let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.id, for: indexPath) as! CityInfoTableViewCell
        
        cell.configureData(filteredList[row])
        
        if !text.isEmpty && !filteredList.isEmpty {
            cell.setKeyword(text)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
