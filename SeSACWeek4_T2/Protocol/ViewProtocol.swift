//
//  ViewProtocol.swift
//  SeSACWeek4_T2
//
//  Created by ez on 7/22/25.
//

import Foundation

@objc protocol ViewProtocol {
    @objc optional static var identifier: String { get }
}
