//
//  ChatListViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    private var filteredList = mockChatList {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initCollectionView()
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
    
    private func initCollectionView() {
        let id = ChatListCollectionViewCell.id
        let xib = UINib(nibName: id, bundle: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(xib, forCellWithReuseIdentifier: id)
        collectionView.configureFlowLayout(numberOfItemsInRow: 1, numberofItemsInColumn: 5)
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

extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let id = ChatListCollectionViewCell.id
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! ChatListCollectionViewCell
        
        cell.configureData(filteredList[row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let id = ChattingViewController.id
        let vc = storyboard?.instantiateViewController(withIdentifier: id) as! ChattingViewController
        
        vc.list = filteredList[row].chatList
        vc.roomName = filteredList[row].chatroomName
        configureNavigationBar(vc)
        navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
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
