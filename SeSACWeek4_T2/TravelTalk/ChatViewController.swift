//
//  ChatViewController.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/20/25.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "ChatViewController"
    
    @IBOutlet var chatTableView: UITableView!
    
    @IBOutlet var chatTextView: UITextView!
    
    @IBOutlet var chatButton: UIButton!
    
    var chats: [Chat] = []
    var chatTitle = ""
    var id = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        initUI()
    }
    
    private func configure() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.register(UINib(nibName: ChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.identifier)
        
        chatTableView.register(UINib(nibName: MeChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MeChatTableViewCell.identifier)
        
        scrollToBottom()
    }
    
    private func initUI() {
        navigationItem.title = chatTitle
        chatTableView.separatorStyle = .none
        
        initChatTextView()
        initChatButton()
    }
    
    private func initChatTextView() {
        chatTextView.text = ""
        
        chatTextView.backgroundColor = .systemGray6
        
        chatTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 50)
        
        chatTextView.clipsToBounds = true
        chatTextView.layer.cornerRadius = 5
    }
    
    private func initChatButton() {
        chatButton.setTitle("", for: .normal)
        chatButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        chatButton.tintColor = .gray
        
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = chats[indexPath.row]
        
        if chat.user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: MeChatTableViewCell.identifier, for: indexPath) as! MeChatTableViewCell
            
            cell.configureUI(rowData: chat)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
            
            cell.configureUI(rowData: chat)
            
            return cell
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chats.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc func chatButtonTapped(sender: UIButton) {
        guard let text = chatTextView.text else { return }
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty { return }
        
        chats.append(Chat(user: ChatList.me, date: "2025-07-12 23:42", message: text))
        
        chatTextView.text = ""
        
        chatTableView.reloadData()
        
        scrollToBottom()
    }
}
