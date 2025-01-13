//
//  ChattingViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-11.
//

import UIKit

class ChattingViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var outlineView: UIView!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var sendButton: UIButton!
    
    private lazy var convertedList: [Chat] = list ?? []
    private var originY: CGFloat?
    private var originHeight: CGFloat?
    
    var list: [Chat]?
    var roomName: String?
    
    static let id = getId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = roomName
        makeDateSeparator()
        initTableView()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let outlineViewOriginY = outlineView.frame.origin.y
        let tableViewOriginHeight = tableView.frame.size.height
        
        originY = originY ?? outlineViewOriginY
        originHeight = originHeight ?? tableViewOriginHeight
        
        let yOffset = abs((originY ?? 0) - outlineViewOriginY)
       
        if yOffset != 0 {
            tableView.frame.size.height = (originHeight ?? 0) - yOffset
            scrollToBottom()
        } else {
            tableView.frame.size.height = originHeight ?? 0
        }
        
        tableView.layoutIfNeeded()
    }
    
    private func configureUI() {
        configureOutlineView()
        configureTextView()
        configureSendButton()
    }
    
    private func configureOutlineView() {
        outlineView.layer.cornerRadius = TravelConstants.cornerRadius
        outlineView.layer.backgroundColor = UIColor.lightGray.cgColor
        outlineView.clipsToBounds = true
    }
    
    private func configureTextView() {
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.text = TravelConstants.textviewPlaceholder
        textView.textColor = .gray
        configureToolbar(textView)
    }
    
    private func configureSendButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "paperplane.fill")
        config.baseBackgroundColor = .clear
        sendButton.configuration = config
        sendButton.isEnabled = false
        sendButton.configurationUpdateHandler = { btn in
            switch btn.state {
            case .disabled:
                btn.configuration?.baseForegroundColor = .gray
            default:
                btn.configuration?.baseForegroundColor = .black
            }
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureToolbar(_ sender: UITextView) {
        let toolbar = UIToolbar()
        let nilButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.items = [nilButton, doneButton]
        toolbar.sizeToFit()
        
        sender.inputAccessoryView = toolbar
    }
}

extension ChattingViewController {
    private func initTableView() {
        let userCellId = OtherChatTableViewCell.id
        let myCellId = MyChatTableViewCell.id
        let dateCellId = DateSeparatorTableViewCell.id
        let userXib = UINib(nibName: userCellId, bundle: nil)
        let myXib = UINib(nibName: myCellId, bundle: nil)
        let dateXib = UINib(nibName: dateCellId, bundle: nil)

        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(userXib, forCellReuseIdentifier: userCellId)
        tableView.register(myXib, forCellReuseIdentifier: myCellId)
        tableView.register(dateXib, forCellReuseIdentifier: dateCellId)
        
        scrollToBottom()
    }
    
    private func scrollToBottom(){
        DispatchQueue.main.async { [self] in
            let indexPath = IndexPath(row: convertedList.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    private func makeDateSeparator() {
        // 함수 3개로 쪼개기 1.첫번째 날짜 만들고 추가하는 함수 2. 인덱스 선정 3. 인덱스에 객체 넣기
        let firstDateString = convertedList.first?.date.stringToDateFormat(TravelConstants.chatDateInputForamt, TravelConstants.dateSeparatorFormat) ?? ""
        let firstSeparator = Chat(user: User.user, date: firstDateString, message: "")

        var indexList: [Int] = []
        
        for i in 0...convertedList.count - 2 {
            let previousDate = convertedList[i].date.stringToDate(TravelConstants.chatDateInputForamt)
            let nextDate = convertedList[i + 1].date.stringToDate(TravelConstants.chatDateInputForamt)
            let formattedPreviousDate = previousDate.formatted(.dateTime.year().month().day())
            let formattedNextDate = nextDate.formatted(.dateTime.year().month().day())
            if  formattedNextDate != formattedPreviousDate {
                indexList.append(i + 1)
            }
        }
        
        for i in indexList.reversed() {
            let dateString = convertedList[i].date.stringToDateFormat(TravelConstants.chatDateInputForamt, TravelConstants.dateSeparatorFormat)
            let separator = Chat(user: User.user, date: dateString, message: "")
            convertedList.insert(separator, at: i)
        }
        
        convertedList.insert(firstSeparator, at: 0)
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        convertedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let chatList = convertedList[row]
        let isUser = chatList.user.rawValue == TravelConstants.user
        let isEmpty = chatList.message.isEmpty
        let id = isUser
            ? isEmpty
                ? DateSeparatorTableViewCell.id : MyChatTableViewCell.id
            : OtherChatTableViewCell.id
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        if isUser {
            if isEmpty {
                (cell as! DateSeparatorTableViewCell).configureData(chatList.date)
            } else {
                (cell as! MyChatTableViewCell).configureData(chatList)
            }
        } else {
            (cell as! OtherChatTableViewCell).configureData(chatList)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChattingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let isTextEmpty = textView.text.isEmpty
    
        sendButton.isEnabled = isTextEmpty ? false : true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textView.text.isEmpty && textView.text == TravelConstants.textviewPlaceholder {
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = TravelConstants.textviewPlaceholder
            textView.textColor = .gray
        }
    }
}
