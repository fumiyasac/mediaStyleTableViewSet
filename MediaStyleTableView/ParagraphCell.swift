//
//  ParagraphCell.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/30.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ParagraphCell: UITableViewCell {

    //UIパーツの配置
    @IBOutlet weak var paragraphTitle: UILabel!
    @IBOutlet weak var paragraphThumb: UIImageView!
    @IBOutlet weak var paragraphDescription: UITextView!
    @IBOutlet weak var paragraphText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //本文のテキストフィールドのリンクを有効にしておく
        paragraphText.dataDetectorTypes = .link
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
