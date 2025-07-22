//
//  TravelTalkViewController.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/19/25.
//

import UIKit

class TravelTalkViewController: UIViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet private var talkSearchBar: UISearchBar!
    
    let datas: [ChatRoom] = ChatList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        initUI()
    }

    @objc private func talkSearchBarEditingDidEndOnExit(sender: UITextField) {
        guard let text = sender.text else { return }
        if text == "" {
            ChatList.fillFilteredList()
            myTableView.reloadData()
            return
        }
        
        ChatList.searchUsers(text)
        
        myTableView.reloadData()
    }
}

extension TravelTalkViewController: MyTableViewProtocol {
    
    func configure() {
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
        
        myTableView.rowHeight = 90
    }
    
    func initUI() {
        navigationItem.title = "TRAVEL TALK"
        
        initBackButton()
        initTalkTableView()
        initTalkSearchBar()
    }
    
    private func initBackButton() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func initTalkTableView() {
        myTableView.separatorStyle = .none
    }
    
    private func initTalkSearchBar() {
        talkSearchBar.placeholder = "친구 이름을 검색해보세요."
        
        talkSearchBar.searchTextField.addTarget(self, action: #selector(talkSearchBarEditingDidEndOnExit), for: .editingDidEndOnExit)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatList.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as! TravelTalkTableViewCell
        
        let talk = ChatList.filteredList[indexPath.row]
        
        cell.configureUI(rowData: talk)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chatViewController = storyboard?.instantiateViewController(withIdentifier: ChatViewController.identifier) as? ChatViewController{
            let talk = ChatList.filteredList[indexPath.row]
            chatViewController.datas = talk.chatList
            chatViewController.chatTitle = talk.chatroomName
            
            navigationController?.pushViewController(chatViewController, animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
