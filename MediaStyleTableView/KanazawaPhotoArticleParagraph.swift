//
//  KanazawaPhotoArticleParagraph.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/12/01.
//  Copyright © 2016年 just1factory. All rights reserved.
//

//デザイン用のダミーデータを仕込むためのクラス（詳細ページ用)
//次のTODO: APIKitを用いたデータの取得をする
class KanazawaPhotoArticleParagraph {
    
    //段落データ
    var paragraphTitle: String
    var paragraphSummary: String
    var paragraphText: String
    var thumbnail: String

    //初期化
    init(paragraphTitle: String, paragraphSummary: String, paragraphText: String, thumbnail: String) {
        self.paragraphTitle = paragraphTitle
        self.paragraphSummary = paragraphSummary
        self.paragraphText = paragraphText
        self.thumbnail = thumbnail
    }

}
