//
//  ViewController.swift
//  HNATextKitDemo
//
//  Created by __无邪_ on 2017/8/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK - 
    

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editorVC = segue.destination as? NoteEditorViewController {
            if "CellSelected" == segue.identifier {
                if let path = tableView.indexPathForSelectedRow {
                    editorVC.note = notes[path.row]
                }
                
            }
        }
    }
    
    
    
    
    
    
    
//    ios 6
    
//    UILabel UITextField UITextView  UIWebView
//    
//         TextKit                    WebKit
//    
//                    CoreText
//    
//                 Core Graphics
    
    
    
    
    
    
    
}

