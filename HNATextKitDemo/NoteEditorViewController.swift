//
//  NoteEditorViewController.swift
//  HNATextKitDemo
//
//  Created by __无邪_ on 2017/8/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController, UITextViewDelegate {

    
    var note: Note!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textView.text = note.contents;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note.contents = textView.text
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
