//
//  ArticleCell.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/29.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    /**
     * Interface BuilderでcellImageViewの属性値を設定しておく
     * 「contentMode → AspectFill, Clip to Bounds → チェック状態」
     * （参考）[iOS]UIImageViewにAspect Fillで画像を表示したらなんかはみ出しちゃった時にすること
     * http://dev.classmethod.jp/smartphone/iphone/uiimageview-aspectfill-clipsubviews/
     */
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
    
    //セルの幅と高さを返すクラスメソッド（配置したUICollectionViewのセルの高さを合わせておく必要がある）
    class func cellOfSize() -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        let height = CGFloat(240)
        return CGSize(width: width, height: height)
    }
    
}
