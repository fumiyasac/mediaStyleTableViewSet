//
//  ConvertHtmlText.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/30.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//HTMLタグを有効にするための構造体
struct ConvertHtmlText {
    
    //HTMLタグを有効にするメソッド
    static func activateHtmlTags(targetString: String) -> NSAttributedString {
        
        //対象のテキスト（この中にはHTMLタグや簡単な直書きのCSSがあることを想定）
        let htmlText: String = targetString
        
        /**
         * 行間を調節するにはNSAttributedString(またはNSMutableAttributedString)を使用する。
         *
         * (イメージ) CSSのline-heightのようなイメージ「line-height: 1.8;」
         * http://easyramble.com/set-line-height-with-swift.html
         * 
         * (参考)【iOS Swift入門 #120】UILabelで複数行の文字列を表示するときに行間を調節する
         * http://swift-studying.com/blog/swift/?p=553
         */
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 2.0
        
        //HTMLに対応した文字列に直す処理とオプションの設定を行う
        let encodedData = htmlText.data(using: String.Encoding.utf8)!
        let attributedOptions : [String : AnyObject] = [
            NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType as AnyObject,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue) as AnyObject,
            NSParagraphStyleAttributeName : paragraph
        ]

        let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            
        return attributedString
    }
}
