//
//  MyTableViewCellProtocol.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/22/25.
//

import Foundation

protocol MyTableViewCellProtocol: ViewProtocol, AnyObject {
    associatedtype DataType
    
    func initUI()
    func configureUI(rowData: DataType)
}
