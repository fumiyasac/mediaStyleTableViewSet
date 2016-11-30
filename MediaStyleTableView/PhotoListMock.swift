//
//  PhotoListMock.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/12/01.
//  Copyright © 2016年 just1factory. All rights reserved.
//

//ダミーデータの一覧を返却する構造体とメソッドを定義
struct PhotoListMock {

    static func getArticlePhotoList() -> [KanazawaPhotoArticle] {
        
        var models: [KanazawaPhotoArticle] = []
        
        //サンプルデータをKanazawaPhotoArticleに投入する
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "旬の魚が安く手に入る「いきいき魚市」",
                mainImage: "image1",
                categoryName: .shopping,
                themeColor: .shopping
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "潮風が心地よい昔ながらの「大野港」",
                mainImage: "image2",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "古都の情緒が今でも残る「ひがし茶屋街」",
                mainImage: "image3",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "金沢でも有名な和菓子「森八」の本店前",
                mainImage: "image4",
                categoryName: .shopping,
                themeColor: .shopping
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "漆器や焼き物などと並ぶ有名な名産品「金箔」",
                mainImage: "image5",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "ひがし茶屋街をはじめとする歴史と歩む街「東山」",
                mainImage: "image6",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "「菊姫」・「天狗舞」をはじめとする銘酒が並ぶ",
                mainImage: "image7",
                categoryName: .shopping,
                themeColor: .shopping
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "旅や観光の合間に一息つける甘味どころの風景",
                mainImage: "image8",
                categoryName: .gourmet,
                themeColor: .gourmet
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "食べるのが勿体無い綺麗さの金沢の和菓子達",
                mainImage: "image9",
                categoryName: .shopping,
                themeColor: .shopping
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "自然と歴史を感じる浅野川を臨む夏の景色",
                mainImage: "image10",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "無電柱化による都市の景観への配慮にも注目",
                mainImage: "image11",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "実家に帰ると必ず食べる家庭の味「キスフライ」",
                mainImage: "image12",
                categoryName: .gourmet,
                themeColor: .gourmet
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "北陸新幹線の開通に伴いリニューアルした「金沢駅」",
                mainImage: "image13",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "北陸生まれなら帰ったら食べたい「８番らーめん」",
                mainImage: "image14",
                categoryName: .gourmet,
                themeColor: .gourmet
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "能登の自然と農家の知恵が生んだ神秘「千枚田」",
                mainImage: "image15",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "前田利家のお膝元の名残を残す「金沢城石川門」",
                mainImage: "image16",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "加賀の銘酒と豊かな恵みを生み出す清流「手取川」",
                mainImage: "image17",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        models.append(
            KanazawaPhotoArticle(
                mainTitle: "金沢に旅行に来たなら絶対に外せない名所「兼六園」",
                mainImage: "image18",
                categoryName: .tourism,
                themeColor: .tourism
            )
        )
        return models
    }
}
