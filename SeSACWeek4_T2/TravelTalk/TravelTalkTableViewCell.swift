//
//  TravelTalkTableViewCell.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/19/25.
//

import UIKit

class TravelTalkTableViewCell: UITableViewCell {

    static let identifier = "TravelTalkTableViewCell"
    
    @IBOutlet var mainUIView: UIView!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func configureUI(rowData: ChatRoom) {
        configureNameLabel(rowData)
        configureMessageLabel(rowData)
        configureDateLabel(rowData)
        configureProfileImageView(rowData)
    }
    
    private func configureNameLabel(_ rowData: ChatRoom) {
        nameLabel.text = rowData.chatroomName
    }
    
    private func configureMessageLabel(_ rowData: ChatRoom) {
        messageLabel.text = rowData.chatList.last?.message
    }
    
    private func configureDateLabel(_ rowData: ChatRoom) {
        
        guard let date = rowData.chatList.last?.date else { return }
        
//        let innerDateFormatter = DateFormatter()
//        innerDateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
//        let innerDate = innerDateFormatter.date(from: date)
//        
//        let outerDateFormatter = DateFormatter()
//        outerDateFormatter.dateFormat = "yy.MM.dd"
//        let outerDate = outerDateFormatter.string(from: innerDate!)
        
        dateLabel.text = date
    }
    
    private func configureProfileImageView(_ rowData: ChatRoom) {
        profileImageView.image = UIImage(named: rowData.chatroomImage)
    }

    private func initUI() {
        initMainUIView()
        initNameLabel()
        initMessageLabel()
        initDateLabel()
        initProfileImageView()
    }
    
    private func initMainUIView() {
        mainUIView.backgroundColor = .clear
    }
    
    private func initNameLabel() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameLabel.numberOfLines = 1
    }
    
    private func initMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 1
    }
    
    private func initDateLabel() {
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        dateLabel.numberOfLines = 1
    }
    
    private func initProfileImageView() {
        profileImageView.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
    }
}
