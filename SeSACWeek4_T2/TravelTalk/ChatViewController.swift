//
//  ChatViewController.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/20/25.
//

import UIKit

class ChatViewController: UIViewController {
    
    static let identifier = "ChatViewController"
    
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet private var chatTextView: UITextView!
    
    @IBOutlet private var chatButton: UIButton!
    
    var datas: [Chat] = []
    var chatTitle = ""
    var lastDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        initUI()
    }
    
    func dateSeparator(cell: UITableViewCell, chat: Chat) {
        let date = String(chat.date.split(separator: " ")[0])
        
        if lastDate == "" {
            lastDate = date
            return
        }
        
        if lastDate != date {
            // 기존 separator 제거 방지
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.width, bottom: 0, right: 0)
            
            // 이미 추가된 separatorView 제거
            cell.contentView.viewWithTag(999)?.removeFromSuperview()
            
            // 하단에 separatorView 추가
            let separatorHeight: CGFloat = 1
            let separatorView = UIView()
            separatorView.backgroundColor = .systemGray5
            separatorView.tag = 999
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(separatorView)
            
            NSLayoutConstraint.activate([
                separatorView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 24),
                separatorView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -24),
                separatorView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: separatorHeight)
            ])
            
            lastDate = date
        }
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.datas.count - 1, section: 0)
            self.myTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc func chatButtonTapped(sender: UIButton) {
        guard let text = chatTextView.text else { return }
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty { return }
        
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        datas.append(Chat(user: ChatList.me, date: dateFormatter.string(from: date), message: text))
        
        chatTextView.text = ""
        
        myTableView.reloadData()
        
        scrollToBottom()
    }
}

extension ChatViewController: MyTableViewProtocol {
    func configure() {
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: ChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.identifier)
        
        myTableView.register(UINib(nibName: MeChatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MeChatTableViewCell.identifier)
        
        scrollToBottom()
    }
    
    func initUI() {
        navigationItem.title = chatTitle
        myTableView.separatorStyle = .none
        
        initChatTextView()
        initChatButton()
    }
    
    private func initChatTextView() {
        chatTextView.text = ""
        
        chatTextView.backgroundColor = .systemGray6
        
        chatTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 50)
        
        chatTextView.clipsToBounds = true
        chatTextView.layer.cornerRadius = 5
        
        chatTextView.alignTextVerticallyInContainer()
    }
    
    private func initChatButton() {
        chatButton.setTitle("", for: .normal)
        chatButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        chatButton.tintColor = .gray
        
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = datas[indexPath.row]
        
        if chat.user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: MeChatTableViewCell.identifier, for: indexPath) as! MeChatTableViewCell
            
            cell.configureUI(rowData: chat)
            
            dateSeparator(cell: cell, chat: chat)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
            
            cell.configureUI(rowData: chat)
            
            dateSeparator(cell: cell, chat: chat)
            
            return cell
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
