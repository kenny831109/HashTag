//
//  OutputViewController.swift
//  HashTag
//
//  Created by 逸唐陳 on 2018/9/21.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import Foundation
import UIKit


class OutPutViewController: UIViewController {
    
    let previusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Previus", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    let messageView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .black
        view.linkTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.red]
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .white
        view.addSubview(previusButton)
        previusButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        previusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        previusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        previusButton.addTarget(self, action: #selector(previus), for: .touchUpInside)
        view.addSubview(messageView)
        messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: previusButton.bottomAnchor, constant: 20).isActive = true
        messageView.delegate = self
    }
    
    @objc func previus() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension OutPutViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        switch URL.scheme ?? "" {
        case "hash" :
            let text = (URL as NSURL).resourceSpecifier!.removingPercentEncoding!
            print(text)
        //            print(textView)
        default:
            break
        }
        return false
    }
}
