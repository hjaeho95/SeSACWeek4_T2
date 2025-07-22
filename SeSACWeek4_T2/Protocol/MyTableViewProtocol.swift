//
//  MyTableViewProtocol.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/22/25.
//

import UIKit

protocol MyTableViewProtocol: UITableViewDelegate, UITableViewDataSource, AnyObject {
    associatedtype DataType
    
    var myTableView: UITableView! { get }
    var datas: [DataType] { get }
    
    func configure()
    func initUI()
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
}
