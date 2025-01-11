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
        searchController.searchBar.placeholder = TravelConstants.searchbarPlaceholder
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = TravelConstants.chatListTitle
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
    
    private func configureNavigationBar(_ vc: UIViewController) {
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(back))
        let image = UIImage(systemName: TravelConstants.backImage)

        backBarButtonItem.tintColor = .black
        backBarButtonItem.image = image
        vc.navigationItem.leftBarButtonItem = backBarButtonItem
    }

    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
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
        let row = indexPath.row
        let id = ChattingViewController.id
        let vc = storyboard?.instantiateViewController(withIdentifier: id) as! ChattingViewController
        
        vc.list = filteredList[row].chatList
        vc.roomName = filteredList[row].chatroomName
        configureNavigationBar(vc)
        navigationController?.pushViewController(vc, animated: true)
        
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
