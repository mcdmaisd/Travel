//
//  ChattingViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class ChattingViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    var list: [Chat]?
    var roomName: String?
    
    static let id = getId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = roomName
        initTableView()
    }
}

extension ChattingViewController {
    private func initTableView() {
        let userCellId = OtherChatTableViewCell.id
        let myCellId = MyChatTableViewCell.id
        let userXib = UINib(nibName: userCellId, bundle: nil)
        let myXib = UINib(nibName: myCellId, bundle: nil)

        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(userXib, forCellReuseIdentifier: userCellId)
        tableView.register(myXib, forCellReuseIdentifier: myCellId)
        
        scrollToBottom()
    }
    
    private func scrollToBottom(){
        DispatchQueue.main.async { [self] in
            let indexPath = IndexPath(row: (list?.count ?? 0) - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let isUser = list?[row].user.rawValue == TravelConstants.user
        let id = isUser ? MyChatTableViewCell.id : OtherChatTableViewCell.id
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        guard let chatList = list?[row] else { return cell }
        
        if isUser {
            (cell as! MyChatTableViewCell).configureData(chatList)
        } else {
            (cell as! OtherChatTableViewCell).configureData(chatList)
        }
        
        return cell
    }
}
