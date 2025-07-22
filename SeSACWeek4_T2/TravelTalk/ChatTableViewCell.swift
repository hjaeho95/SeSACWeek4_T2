//
//  ChatTableViewCell.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/20/25.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    static let identifier = "ChatTableViewCell"
    
    @IBOutlet private var mainUIView: UIView!
    
    @IBOutlet private var profileImageView: UIImageView!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        initProfileImageView()
    }
    
}

extension ChatTableViewCell: MyTableViewCellProtocol {
    func initUI() {
        initMainUIView()
        initProfileImageView()
        initNameLabel()
        initMessageLabel()
        initTimeLabel()
    }
    
    func configureUI(rowData: Chat) {
        configureProfileImageView(rowData)
        configureNameLabel(rowData)
        configureMessageLabel(rowData)
        configureTimeLabel(rowData)
    }
    
    private func configureProfileImageView(_ rowData: Chat) {
        profileImageView.image = UIImage(named: rowData.user.image)
    }
    
    private func configureNameLabel(_ rowData: Chat) {
        nameLabel.text = rowData.user.name
    }
    
    private func configureMessageLabel(_ rowData: Chat) {
        messageLabel.text = rowData.message
    }
    
    private func configureTimeLabel(_ rowData: Chat) {
        
        timeLabel.text = rowData.date.convertDateFormat(innerDateFormat: "yyyy-MM-dd HH:mm", outerDateFormat: "hh:mm a", locale: Locale(identifier: "ko-KR"))
    }
    
    private func initMainUIView() {
        mainUIView.backgroundColor = .clear
    }
    
    private func initProfileImageView() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    private func initNameLabel() {
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.numberOfLines = 1
    }
    
    private func initMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
        
        messageLabel.layer.borderWidth = 1
        messageLabel.layer.borderColor = UIColor.gray.cgColor
        
        messageLabel.clipsToBounds = true
        messageLabel.layer.cornerRadius = 8
    }
    
    private func initTimeLabel() {
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.textColor = .gray
        timeLabel.numberOfLines = 1
    }
}
