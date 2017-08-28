//
//  SyntaxHighlightTextStorage.swift
//  HNATextKitDemo
//
//  Created by __无邪_ on 2017/8/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class SyntaxHighlightTextStorage: NSTextStorage {
    
    let backingStore = NSMutableAttributedString()
    
    
    override var string: String {
        return backingStore.string
    }
    
    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [String : Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }
    
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        print("replaceCharactersInRange:\(NSStringFromRange(range)) withString:\(str)")
        beginEditing()
        
        backingStore.replaceCharacters(in: range, with: str)
//        edited((.editedCharacters | .editedAttributes), range: range, changeInLength: (str as String).length - range.length)
        edited(.editedCharacters, range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    override func setAttributes(_ attrs: [String : Any]?, range: NSRange) {
        print("setAttributes:\(String(describing: attrs)) range:\(NSStringFromRange(range))")
        
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    func applyStylesToRange(searchRange: NSRange) {
        // 1. create some fonts
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        let boldFontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont.init(descriptor: boldFontDescriptor!, size: 0)
        let normalFont = UIFont.preferredFont(forTextStyle: .body)
        
        do {
            // 2. match items surrounded by asterisks
            let regexStr = "(\\*\\w+(\\s\\w+)*\\*)"
            let regex = try NSRegularExpression.init(pattern: regexStr, options: [])
            
            let boldAttributes = [NSFontAttributeName : boldFont]
            let normalAttributes = [NSFontAttributeName : normalFont]
            
            // 3. iterate over each match, making the text bold
            // 3. 匹配字符串中内容
            
            regex.enumerateMatches(in: backingStore.string, options: [], range: searchRange, using: { (match : NSTextCheckingResult?, flags, stop) in
                let matchRange = match?.rangeAt(1)
                self.addAttributes(boldAttributes, range: matchRange!)
                // 4. reset the style to the original
                let maxRange = (matchRange?.location)! + (matchRange?.length)!
                if maxRange + 1 < self.length {
                    self.addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
                }
            })
            
        }catch {
            print(error)
        }
        
    }
    func performReplacementsForRange(changedRange: NSRange) {
        var extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(changedRange.location, 0)))
        extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(NSMaxRange(changedRange), 0)))
        applyStylesToRange(searchRange: extendedRange)
    }
    override func processEditing() {
        performReplacementsForRange(changedRange: self.editedRange)
        super.processEditing()
    }
    
    
}
