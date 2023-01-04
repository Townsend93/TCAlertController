//
//  TCAlertController.swift
//  TCAlertController
//
//  Created by ls_tc on 2022/12/23.
//

import Foundation
import UIKit

public class TCAlertController: UIViewController {
    
    /// 是否可点击背景，dimiss alert， 默认false
    public var canTouchDimissOnBackground: Bool = true {
        didSet {
            dimimingView.isUserInteractionEnabled = canTouchDimissOnBackground
        }
    }
    
    var contents: [TCAlertContent]
    
    var actions: [TCAlertAction]
    
    /// 整个alert 容器
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var dimimingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimissAction))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = canTouchDimissOnBackground
        return view
    }()
    
    /// 显示内容容器 (title, message)
    private lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    /// 按钮容器 (cancel, confirm)
    private lazy var actionStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    public init(contents: [TCAlertContent],actions: [TCAlertAction]) {
        self.contents = contents
        self.actions = actions
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func dimissAction() {
        dismiss(animated: true)
    }

}

extension TCAlertController {
    /// 设置视图
    private func setupUI() {
        view.backgroundColor = .clear

        view.addSubview(dimimingView)
        dimimingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimimingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimimingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimimingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimimingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        containerView.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -20),
        ])
        
        let sp = UIView()
        if #available(iOS 13.0, *) {
            sp.backgroundColor = UIColor.separator.withAlphaComponent(0.3)
        } else {
            sp.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        }
        containerView.addSubview(sp)
        sp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sp.heightAnchor.constraint(equalToConstant: 1),
            sp.topAnchor.constraint(equalTo: contentStack.bottomAnchor),
            sp.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            sp.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        
        containerView.addSubview(actionStack)
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionStack.topAnchor.constraint(equalTo: sp.bottomAnchor),
            actionStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            actionStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            actionStack.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        setupContent()
        setupAction()
    }
    
    /// 设置内容
    private func setupContent() {
        for item in contents {
            let content = item.content
            contentStack.addArrangedSubview(content)
            if let height = item.height {
                content.translatesAutoresizingMaskIntoConstraints = false
                content.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
    
    private func setupAction() {
        var btns: [UIButton] = []
        for (index, item) in actions.enumerated() {
            let btn = createActionButton(for: item)
            btn.tag = index
            actionStack.addArrangedSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btns.append(btn)
            
            if index < actions.count - 1 {
                let sp = UIView()
                if #available(iOS 13.0, *) {
                    sp.backgroundColor = UIColor.separator.withAlphaComponent(0.3)
                } else {
                    sp.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
                }
                actionStack.addArrangedSubview(sp)
                sp.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    sp.heightAnchor.constraint(equalToConstant: 30),
                    sp.widthAnchor.constraint(equalToConstant: 1)
                ])
                
            }
            
        }
                
        if let first = btns.first {
            for btn in btns {
                if btn != first {
                    btn.widthAnchor.constraint(equalTo: first.widthAnchor).isActive = true
                }
            }
        }
        
        
    }
    
    private func createActionButton(for action: TCAlertAction) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = action.font
        btn.setTitle(action.title, for: .normal)
        btn.setTitleColor(action.color, for: .normal)
        btn.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        return btn
    }
    
}

extension TCAlertController {
    @objc
    private func tapAction(sender: UIButton) {
        dimissAction()
        actions[sender.tag].handler?()
    }
}


extension TCAlertController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TCAlertAnimator()
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TCAlertAnimator()
    }
    

}
