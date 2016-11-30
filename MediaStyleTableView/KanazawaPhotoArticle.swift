//
//  KanazawaPhotoArticle.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/30.
//  Copyright © 2016年 just1factory. All rights reserved.
//

//デザイン用のダミーデータを仕込むためのクラス(コレクションビュー用)
class KanazawaPhotoArticle {
    
    //メインデータの変数
    var mainTitle: String
    var mainImage: String
    var categoryName: CategoryName
    var themeColor: WebColorList
 
    //初期化
    init(mainTitle: String, mainImage: String, categoryName: CategoryName, themeColor: WebColorList) {
        self.mainTitle = mainTitle
        self.mainImage = mainImage
        self.categoryName = categoryName
        self.themeColor = themeColor
    }
}
