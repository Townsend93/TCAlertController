//
//  TCAlertAction.swift
//  TCAlertController
//
//  Created by ls_tc on 2022/12/23.
//

import Foundation
import UIKit

public typealias TCAlertActionHandler = () -> Void

public protocol TCAlertAction {
    /// 按钮高度
    var  height: CGFloat { get }
    /// 标题
    var title: String { get }
    /// 标题字体
    var font: UIFont { get }
    /// 标题颜色
    var color: UIColor { get }
    /// action 回调
    var handler: TCAlertActionHandler? { get }
    
}

public struct TCAlertCancelAction: TCAlertAction {
    public var height: CGFloat = 50

    public var title: String
    
    public var font: UIFont
    
    public var color: UIColor
    
    public var handler: TCAlertActionHandler?
    
    public init(height: CGFloat = 50, title: String, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = UIColor.black, handler: TCAlertActionHandler? = nil) {
        self.height = height
        self.title = title
        self.font = font
        self.color = color
        self.handler = handler
    }
    
}

public struct TCAlertConfirmAction: TCAlertAction {
    
    public var height: CGFloat = 50
    
    public var title: String
    
    public var font: UIFont
    
    public var color: UIColor
    
    public var handler: TCAlertActionHandler?
    
    public init(height: CGFloat = 50, title: String, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = UIColor.systemBlue, handler: TCAlertActionHandler? = nil) {
        self.height = height
        self.title = title
        self.font = font
        self.color = color
        self.handler = handler
    }
}
