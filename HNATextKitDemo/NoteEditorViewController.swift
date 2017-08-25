//
//  NoteEditorViewController.swift
//  HNATextKitDemo
//
//  Created by __无邪_ on 2017/8/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var textView: UITextView!
    var note: Note!
    var timeView: TimeIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(notification:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        textView.text = note.contents;
        textView.font = UIFont.preferredFont(forTextStyle: .body)

        
        timeView = TimeIndicatorView(date: note.timestamp)
        textView.addSubview(timeView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    func updateTimeIndicatorFrame() {
        timeView.updateSize()
        timeView.frame = timeView.frame.offsetBy(dx: textView.frame.width - timeView.frame.width, dy: 0)
        let exclusionPath = timeView.curvePathWithOrigin(origin: timeView.center)
        textView.textContainer.exclusionPaths = [exclusionPath]
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
