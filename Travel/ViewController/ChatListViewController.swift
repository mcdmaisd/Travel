//
//  ChatListViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var filteredList = mockChatList {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initTableView()
    }
}

extension ChatListViewController {
    private func initNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요"
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "TRAVEL TALK"
    }
    
    private func initTableView() {
        let id = ChatListTableViewCell.id
        let xib = UINib(nibName: ChatListTableViewCell.id, bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(xib, forCellReuseIdentifier: id)
    }
    
    private func searchRoomName(_ text: String) {
        var result: [ChatRoom] = []
        
        for chatroom in mockChatList {
            if let _ = chatroom.chatroomName.range(of: text, options: .caseInsensitive) {
                result.append(chatroom)
            }
        }
        
        filteredList = result
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let id = ChatListTableViewCell.id
        let cell = tableView.dequeueReusableCell(withIdentifier: id) as! ChatListTableViewCell
        
        cell.configureData(filteredList[row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChatListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        text.isEmpty ? filteredList = mockChatList : searchRoomName(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredList = mockChatList
    }
}
