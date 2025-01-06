//
//  ViewController.swift
//  Travel
//
//  Created by ilim on 2025-01-03.
//
// 제가 자주 쓰는 Microsoft To Do: Lists & Tasks 앱과 유사한 기능을 추가해보았습니다.
import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var todoTextField: UITextField!
    @IBOutlet var uiview: UIView!
    @IBOutlet var addButton: UIButton!
    
    private var shoppingList = UserDefaultsManager.shared.read()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let todo = todoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if todo.count < 1 {
            presentAlert(message: TravelConstants.minimumCharacterMessage)
            todoTextField.text?.removeAll()
            return
        }
        
        let sectionIndex = 0
        let item = ShoppingItem()
        item.todo = todo
        
        shoppingList[sectionIndex].append(item)
        UserDefaultsManager.shared.save(list: shoppingList)
        tableView.reloadSections(IndexSet(integer: sectionIndex), with: .automatic)
    }
    
    private func configureUI() {
        configureUIView()
        configureTodoTextField()
        configureAddButton()
    }
    
    private func configureTodoTextField() {
        todoTextField.clearButtonMode = .whileEditing
        todoTextField.placeholder = TravelConstants.todoPlacdHolder
        todoTextField.backgroundColor = .clear
        todoTextField.borderStyle = .none
        todoTextField.font = .systemFont(ofSize: 20)
    }
    
    private func configureUIView() {
        uiview.layer.cornerRadius = TravelConstants.cornerRadius
        uiview.backgroundColor = .lightGray
    }
    
    private func configureAddButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        config.baseForegroundColor = .black
        config.title = "추가"
        config.cornerStyle = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        addButton.configuration = config
    }
    
    @objc
    private func doneButtonTapped(_ sender: UIButton) {
        let row = sender.tag
        let section = sender.isSelected ? 1 : 0
        let item = shoppingList[section][row]
        
        if item.isDone {
            let index = getIndex(section, row)
            shoppingList[section].remove(at: row)
            shoppingList[section - 1].insert(item, at: index)
        } else {
            item.isPrimary = false
            shoppingList[section].remove(at: row)
            shoppingList[section + 1].insert(item, at: 0)
        }
        
        item.isDone.toggle()
        UserDefaultsManager.shared.save(list: shoppingList)
        tableView.reloadData()
    }
    
    @objc
    private func bookmarkButtonTapped(_ sender: UIButton) {
        let section = 0
        let row = sender.tag
        let list = shoppingList[section]
        let item = list[row]
        
        if list.count != 1 {
            if !item.isPrimary {
                shoppingList[section].remove(at: row)
                shoppingList[section].insert(item, at: 0)
            }
        }
        
        item.isPrimary.toggle()
        UserDefaultsManager.shared.save(list: shoppingList)
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    private func getIndex(_ section: Int, _ row: Int) -> Int {
        let list = shoppingList[0]
        let count = list.count
        let item = shoppingList[section][row]
        let index = count > item.originalIndex ? item.originalIndex : count
        var temp = 0
        
        if count > index {
            for i in index ..< count {
                if list[i].isPrimary {
                    temp += 1
                }
            }
        }
        
        return index + temp
    }
}

extension ShoppingTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let item = shoppingList[section][row]
        let isDone = item.isDone
        let isPrimary = item.isPrimary
        let originalIndex = item.originalIndex
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelConstants.shoppingCellId, for: indexPath) as! ShoppingTableViewCell
        
        let doneButton = cell.statusChangebuttons[0]
        let bookmarkButton = cell.statusChangebuttons[1]
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        
        doneButton.tag = row
        bookmarkButton.tag = row
        cell.todoLabel.tag = row
        
        cell.todoLabel.text = item.todo
        print(section, row, isDone, isPrimary)
        if originalIndex == -1 {
            shoppingList[section][row].originalIndex = row
        }
        
        if isDone {
            cell.todoLabel.attributedText = cell.todoLabel.text?.strikeThrough()
            cell.todoLabel.textColor = .gray
            doneButton.isSelected = true
            item.isPrimary = false
            bookmarkButton.isSelected = false
            bookmarkButton.isUserInteractionEnabled = false
        } else if isPrimary {
            bookmarkButton.isSelected = true
            item.originalIndex = row
            cell.todoLabel.font = .boldSystemFont(ofSize: TravelConstants.boldSize)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        let text = shoppingList[section][row].todo
        
        self.presentAlert(message: text)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        TravelConstants.sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        shoppingList[section].count == 0 ? nil : TravelConstants.sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if editingStyle == .delete {
            shoppingList[section].remove(at: row)
            UserDefaultsManager.shared.save(list: shoppingList)
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        shoppingList[section].count == 0 ? 0 : 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

