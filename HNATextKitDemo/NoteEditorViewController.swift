//
//  NoteEditorViewController.swift
//  HNATextKitDemo
//
//  Created by __无邪_ on 2017/8/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//


//  NSTextStorage的功能是存储文本，并通过字符串属性渲染文本。当文本内容发生任何变化的时候，它会告知布局管理器（Layout Manager）

//  NSLayoutManager的功能是从NSTextStorage中获取文本并在屏幕上渲染文本。它将作为你应用中的布局引擎。

//  NSTextContainer的功能是在屏幕上描绘一个几何图形区域，要显示的文本就是在这个区域内进行渲染的。每个Text Container一般都和一和UITextView相关联。你可以实现一个NSTextContainer的子类，描绘一个复杂的几何图形，让文本在其中进行渲染。


import UIKit

class NoteEditorViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var textView: UITextView!
    var note: Note!
    var timeView: TimeIndicatorView!
    var textStorage: SyntaxHighlightTextStorage!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(notification:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
//        textView.text = note.contents;
//        textView.font = UIFont.preferredFont(forTextStyle: .body)

        self.edgesForExtendedLayout = UIRectEdge.bottom;
        
        createTextView()
        textView.isScrollEnabled = true
        
        timeView = TimeIndicatorView(date: note.timestamp)
        textView.addSubview(timeView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 
    func createTextView() {
        // 1. Create the text storage that backs the editor
        let attrs = [NSFontAttributeName : UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: note.contents, attributes: attrs)
        textStorage = SyntaxHighlightTextStorage()
        textStorage.append(attrString)
        
        var newTextViewRect = self.view.bounds
        newTextViewRect.origin.y = 64;
        
        // 2. Create the layout manager
        let layoutManager = NSLayoutManager()
        
        // 3. Create a text container
        let containerSize = CGSize(width: newTextViewRect.width, height: CGFloat.greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        // 4. Create a UITextView
        textView = UITextView(frame: newTextViewRect, textContainer: container)
        textView.delegate = self
        self.view.addSubview(textView)
    }
    
    // MARK: - Notification
    
    @objc private func preferredContentSizeChanged(notification: NSNotification) {
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        updateTimeIndicatorFrame()
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note.contents = textView.text
    }
    
    
    // MARK: - 
    
    override func viewDidLayoutSubviews() {
        updateTimeIndicatorFrame()
        textView.frame = view.bounds
    }
    func updateTimeIndicatorFrame() {
        timeView.updateSize()
        timeView.frame = timeView.frame.offsetBy(dx: textView.frame.width - timeView.frame.width, dy: 0)
        let exclusionPath = timeView.curvePathWithOrigin(origin: timeView.center)
        textView.textContainer.exclusionPaths = [exclusionPath]
    }
    
    // MARK: -
    
    func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
        textView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight)
    }
    @objc func keyboardDidShow(notification: NSNotification) {
        if let rectValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardSize = rectValue.cgRectValue.size
            updateTextViewSizeForKeyboardHeight(keyboardHeight: keyboardSize.height)
        }
    }
    @objc func keyboardDidHide(notification: NSNotification) {
        updateTextViewSizeForKeyboardHeight(keyboardHeight: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
