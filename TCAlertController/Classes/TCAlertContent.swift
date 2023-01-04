//
//  TCAlertContent.swift
//  TCAlertController
//
//  Created by ls_tc on 2022/12/23.
//

import Foundation
import UIKit

// Alert 显示的内容
public protocol TCAlertContent {
    /// 内容视图如：文本（UILable）、图片(UIImageView)、文本输入框(UItextFiled)等
    var content: UIView { get }
    
    /// 内容视图高度，如果为nil，内容自适应
    var height: CGFloat? { get }
}

// 空白间距
public struct TCAlertSpaceContent: TCAlertContent {
    
    public var content: UIView = UIView()
    
    public var height: CGFloat?
    
    public init(height: CGFloat) {
        self.height = height
    }
    
}

// 文本内容
public struct TCAlertTextContent: TCAlertContent {
    
    public var content: UIView
    
    public var height: CGFloat?
    
    public init(content: UIView? = nil, height: CGFloat? = nil, text: String?) {
        let lab = defaultLable()
        lab.text = text
        self.content = content ?? lab
        self.height = height
    }
    
}

private func defaultLable() -> UILabel {
    let lab = UILabel()
    lab.textColor = UIColor.black
    lab.textAlignment = .left
    lab.numberOfLines = 0
    return lab
}
