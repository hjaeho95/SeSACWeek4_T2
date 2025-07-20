//
//  TravelTalkViewController.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/19/25.
//

import UIKit

class TravelTalkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var talkTableView: UITableView!
    
    @IBOutlet var talkSearchBar: UISearchBar!
    
    let talks = ChatList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        initUI()
    }
    
    private func configure() {
        talkTableView.delegate = self
        talkTableView.dataSource = self
        
        talkTableView.register(UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
        
        talkTableView.rowHeight = 90
    }
    
    private func initUI() {
        navigationItem.title = "TRAVEL TALK"
        
        initBackButton()
        initTalkTableView()
        initTalkSearchBar()
    }
    
    private func initBackButton() {
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    private func initTalkTableView() {
        talkTableView.separatorStyle = .none
    }
    
    private func initTalkSearchBar() {
        talkSearchBar.placeholder = "친구 이름을 검색해보세요."
        
        talkSearchBar.searchTextField.addTarget(self, action: #selector(talkSearchBarEditingDidEndOnExit), for: .editingDidEndOnExit)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as! TravelTalkTableViewCell
        
        let talk = talks[indexPath.row]
        
        cell.configureUI(rowData: talk)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chatViewController = storyboard?.instantiateViewController(withIdentifier: ChatViewController.identifier) as? ChatViewController{
            let talk = talks[indexPath.row]
            chatViewController.chats = talk.chatList
            chatViewController.chatTitle = talk.chatroomName
            chatViewController.id = talk.chatroomId
            
            navigationController?.pushViewController(chatViewController, animated: true)
        }
        
        
    }

    @objc private func talkSearchBarEditingDidEndOnExit(sender: UITextField) {
        print(#function)
        print(sender.text)
    }
}
