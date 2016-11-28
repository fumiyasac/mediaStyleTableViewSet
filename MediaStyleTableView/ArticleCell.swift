//
//  ArticleCell.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/29.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    /**
     * 画像のgetter/setterの設定をする
     * （参考）【Swift】セッター(Setter)、ゲッター(Getter)の処理を書く
     * http://qiita.com/yuinchirn/items/c1bc87494cb758a6b0ca
     */
    var image: UIImage? {
        set {
            self.cellImageView?.image = newValue
        }
        get {
            return self.cellImageView?.image
        }
    }

    //セルの幅と高さを返すクラスメソッド
    class func cellOfSize() -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        let height = CGFloat(240)
        return CGSize(width: width, height: height)
    }
    
}
