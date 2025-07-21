//
//  MeChatTableViewCell.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/20/25.
//

import UIKit

class MeChatTableViewCell: UITableViewCell {

    static let identifier = "MeChatTableViewCell"
    
    @IBOutlet var mainUIView: UIView!
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    func configureUI(rowData: Chat) {
        configureMessageLabel(rowData)
        configureTimeLabel(rowData)
    }
    
    private func configureMessageLabel(_ rowData: Chat) {
        messageLabel.text = rowData.message
    }
    
    private func configureTimeLabel(_ rowData: Chat) {
        timeLabel.text = rowData.date.convertDateFormat(innerDateFormat: "yyyy-MM-dd HH:mm", outerDateFormat: "hh:mm a", locale: Locale(identifier: "ko-KR"))
    }
    
    
    private func initUI() {
        initMainUIView()
        initMessageLabel()
        initTimeLabel()
    }
    
    private func initMainUIView() {
        mainUIView.backgroundColor = .clear
    }
    
    private func initMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
        
        messageLabel.backgroundColor = .systemGray5
        
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
