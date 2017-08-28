//
//  Note.swift
//  HNATextKitDemo
//
//  Created by __无邪_ on 2017/8/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class Note: NSObject {
    var contents: String
    let timestamp: NSDate
    
    // an automatically generated note title, based on the first line of the note
    var title: String {
        // split into lines
        let lines = contents.components(separatedBy: NSCharacterSet.newlines)
        // return the first
        return lines[0]
    }
    
    init(text: String) {
        contents = text
        timestamp = NSDate()
    }
}

// some default notes to play with
var notes = [
    Note(text: "Shopping List\r\r1. Cheese\r2. Biscuits\r3. Sausages\r4. *IMPORTANT* Cash for going out!\r5. -potatoes-\r6. A copy of iOS8 by tutorials\r7. A new iPhone\r8. A present for mum"),
    Note(text: "Meeting notes\rA long and drawn out meeting, it lasted hours and hours and hours!"),
    Note(text: "Perfection is achieved not when there is nothing left to add ... \n\nPerfection is achieved not when there is nothing left to add, but when there is nothing left to take away - Antoine de Saint-Exupery"),
    Note(text: "Notes on Swift\nThis new language from Apple is changing iOS development as we know it!"),
    Note(text: "Meeting notes\rA dfferent meeting, just as long and boring"),
    Note(text: "A collection of thoughts\rWhy do birds sing? Why is the sky blue? Why is it so hard to create good test data?")
]
