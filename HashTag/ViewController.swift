//
//  ViewController.swift
//  HashTag
//
//  Created by 逸唐陳 on 2018/7/25.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import UIKit

struct user {
    let id: String
    let name: String
}

class ViewController: UIViewController {
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let messageView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isEditable = false
        view.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        view.textColor = .black
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var listView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
        return tableView
    }()
    
    var count = 0
    let result = [user(id: "aaaaa", name: "章魚哥"),user(id: "bbbbb", name: "烏賊哥"),user(id: "ccccc", name: "海豚"),user(id: "ddddd", name: "國王企鵝"),user(id: "ddddd", name: "國王 "), user(id: "ddddd", name: "天使 雞排")]
    var searchList = [user(id: "aaaaa", name: "章魚哥"),user(id: "bbbbb", name: "烏賊哥"),user(id: "ccccc", name: "海豚"),user(id: "ddddd", name: "國王企鵝")]
    var currentRange: NSRange?
    var message: NSAttributedString?
    var resultCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(nextButton)
        nextButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        view.addSubview(messageView)
        messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20).isActive = true
//        messageView.text = "This is an #yewjl329lds test #wqewqmdw21"
//        messageView.resolveHashTags(result: result)
        messageView.delegate = self
        view.addSubview(listView)
        listView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        listView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        listView.delegate = self
        listView.dataSource = self
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func nextVC() {
        let test = messageView.attributedText.getFullString()
        print(test)
//        let vc = OutPutViewController()
//        vc.messageView.attributedText = message!
//        self.present(vc, animated: true, completion: nil)
    }
    
//    func addTag(text: String, range: NSRange) {
//        messageView.attributedText
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageView.resignFirstResponder()
    }


}

extension ViewController: UITextViewDelegate {
    
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
    
//    func textViewDidChange(_ textView: UITextView) {
//        if currentRange != nil && !listView.isHidden {
//            let cursorPosition = textView.selectedRange
//            let start = cursorPosition.location - 1
//            let range = NSMakeRange(start, 1)
//            let string = textView.text as NSString
////            let searchRange = NSRange(location: currentRange!.location, length: cursorPosition.location - currentRange!.location)
////            let searchString = string.substring(with: searchRange)
//            let word = string.substring(with: range)
//            if word == "@" {
//                listView.isHidden = false
//
//            }else {
//                let searchRange = NSRange(location: currentRange!.location, length: cursorPosition.location - currentRange!.location)
//                let searchString = string.substring(with: searchRange)
//                print(searchString)
//                let temp = result.filter({$0.name.containsIgnoringCase(find: String(searchString.dropFirst()))})
//                if temp.count == 0 {
//                    listView.isHidden = true
//                }
//            }
//        }
//    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        let string = textView.text as NSString
//        let cursorPosition = textView.selectedRange
//        if currentRange != nil {
//            let range = NSRange(location: currentRange!.location, length: cursorPosition.location - currentRange!.location)
//            let searchString = string.substring(with: range)
//            let temp = result.filter({$0.name.containsIgnoringCase(find: String(searchString.dropFirst()))})
//            if temp.count > 0 || searchString == "@" {
//                listView.isHidden = false
//            }else {
//                listView.isHidden = true
//            }
//        }
//    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        let cursorPosition = textView.selectedRange
        if cursorPosition.location == 0 {
            currentRange = cursorPosition
            listView.isHidden = true
        }else {
            let start = cursorPosition.location - 1
            let previusLocation = cursorPosition.location - 2
            let previusRange = NSMakeRange(previusLocation, 1)
            let range = NSMakeRange(start, 1)
            let string = textView.text as NSString
            let word = string.substring(with: range)
            if word == "@" {
                if previusRange.location == -1 {
                    currentRange = range
                    listView.isHidden = false
                }else {
                    let previusWord = string.substring(with: previusRange)
                    if previusWord.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                        currentRange = range
                        listView.isHidden = false
                    }
                }
            }else if word == " " {
                if previusRange.location < 0 {
                    currentRange = nil
                    listView.isHidden = true
                }else {
                    let previusWord = string.substring(with: previusRange)
                    if previusWord == "@" {
                        currentRange = previusRange
                        listView.isHidden = false
                    }else {
                        currentRange = nil
                        listView.isHidden = true
                    }
                }
            }
        }
        
        if currentRange != nil {
            let string = textView.text as NSString
            let range = NSRange(location: currentRange!.location, length: cursorPosition.location - currentRange!.location)
            let searchString = string.substring(with: range)
            let temp = result.filter({$0.name.containsIgnoringCase(find: String(searchString.dropFirst()))})
            if temp.count > 0 || searchString == "@" {
                listView.isHidden = false
            }else {
                listView.isHidden = true
            }
        }

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if range.location < textView.attributedText.length {
            var shouldReplace = false
            var tokenAttrRange = NSRange()
            var currentReplacementRange = range
            let tokenAttr = NSAttributedString.Key.link
            
            if range.length == 0 {
                if nil != textView.attributedText.attribute(tokenAttr, at: range.location, effectiveRange: &tokenAttrRange) {
                    currentReplacementRange = NSUnionRange(currentReplacementRange, tokenAttrRange)
                    shouldReplace = true
                }
            } else {
                // search the range for any instances of the desired text attribute
                textView.attributedText.enumerateAttribute(tokenAttr, in: range, options: .longestEffectiveRangeNotRequired, using: { (value, attrRange, stop) in
                    // get the attribute's full range and merge it with the original
                    if nil != textView.attributedText.attribute(tokenAttr, at: attrRange.location, effectiveRange: &tokenAttrRange) {
                        currentReplacementRange = NSUnionRange(currentReplacementRange, tokenAttrRange)
                        shouldReplace = true
                    }
                })
            }
            
            if shouldReplace {
                // remove the token attr, and then replace the characters with the input str (which can be empty on a backspace)
                currentReplacementRange.length += 1
                currentReplacementRange.location -= 1
                let mutableAttributedText = textView.attributedText.mutableCopy() as! NSMutableAttributedString
                mutableAttributedText.removeAttribute(tokenAttr, range: currentReplacementRange)
                mutableAttributedText.replaceCharacters(in: currentReplacementRange, with: text)
                textView.attributedText = mutableAttributedText
                
                // set the cursor position to the end of the edited location
                if let cursorPosition = textView.position(from: textView.beginningOfDocument, offset: currentReplacementRange.location + text.lengthOfBytes(using: .utf8)) {
                    textView.selectedTextRange = textView.textRange(from: cursorPosition, to: cursorPosition)
                }
                
                return false
            }
        }
        messageView.typingAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
        return true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = searchList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentRange != nil {
//            currentRange?.length = result[indexPath.row].name.count
//            messageView.addTag(text: result[indexPath.row].name, range: currentRange!)
            let attribute = NSMutableAttributedString(attributedString: messageView.attributedText)
            let tag = NSAttributedString(string: "@\(searchList[indexPath.row].name)", attributes: [NSAttributedString.Key.link : "@\(searchList[indexPath.row].id)", NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
            let space = NSAttributedString(string: " ")
            attribute.deleteCharacters(in: currentRange!)
            attribute.insert(tag, at: currentRange!.location)
            attribute.insert(space, at: messageView.selectedRange.location + searchList[indexPath.row].name.count)
            messageView.attributedText = attribute
            messageView.typingAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
            listView.isHidden = true
            message = messageView.attributedText

        }
    }
    
}

