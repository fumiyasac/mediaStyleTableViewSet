//
//  ParagraphListMock.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/12/01.
//  Copyright © 2016年 just1factory. All rights reserved.
//

//ダミーパラグラフデータの一覧を返却する構造体とメソッドを定義
struct ParagraphListMock {

    static func getParagraphList() -> [KanazawaPhotoArticleParagraph] {

        var paragraphModels: [KanazawaPhotoArticleParagraph] = []

        //サンプルデータをKanazawaPhotoArticleParagraphに投入する
        paragraphModels.append(
            KanazawaPhotoArticleParagraph(
                paragraphTitle: "当サンプル「石川の写真周遊録」について",
                paragraphSummary: "このサンプルに関する説明と作った経緯、そしてこの中で使用している技術等の概要を説明します。",
                paragraphText: "今回作成しましたサンプルに関しては、自分の生まれ故郷でもある石川県と金沢市の写真アプリの参考例として作成しました。<br>"
                    + "また最近ではSwiftが個人的に一番お気に入りでもあり、その中でもUIまわりの実装が特に一番好きな部分でもあったこともあって「そういえば最近金沢に戻ったり、実家に帰ってなかったな」と感じたので年末が近くなって急に実家が少し恋しく？なったので勢いとAdventCalendarのネタも兼ねて作成してみました。<br>"
                    + "要所要所に散りばめたアニメーションを組み合わせてみましたので写真と一緒にUI表現もお楽しみください！<br><br>"
                    + "<strong>写真のカテゴリについて：</strong><br>"
                    + "★<strong style=\"color:#ff803a;\">グルメ・お食事</strong><br>"
                    + "★<strong style=\"color:#52cb52;\">ショッピング・お買い物</strong><br>"
                    + "★<strong style=\"color:#3fc5e2;\">観光・街めぐり</strong><br>"
                    + "★<strong style=\"color:#feca2c;\">ホテル・宿泊</strong><br>"
                    + "★<strong style=\"color:#ff6c6c;\">イベント・催し物</strong><br><br>"
                    + "写真の内容には結構カテゴリにばらつきがありますがそこはご愛嬌...<br>"
                    + "(写真は自前で撮影したものを使用しています。)",
                thumbnail: "paragraph1"
            )
        )
        paragraphModels.append(
            KanazawaPhotoArticleParagraph(
                paragraphTitle: "サンプルの概要と今後の開発について",
                paragraphSummary: "このサンプルに関する説明と作った経緯、そしてこの中で使用している技術等の概要を説明します。",
                paragraphText: "今回はアニメーションの使い方と機能ごとの表現をテーマにサンプルを作成してみました。<br>"
                    + "UIViewController間の遷移時に使用したカスタムトランジションをはじめ、一覧ページのデザインに調和するセルのフェードアニメーションやナビゲーションとの組み合わせ方、スクロール方向に合わせたナビゲーション等の動きでも下品な表現にならない心地よいタイミングには自分なりに気を配っています。<br>"
                    + "(iOS10からのUIViewPropertyAnimatorによるアニメーションは使用していません)<br>"
                    + "作成にあたってインスパイアを受けた記事は下記になります。サンプルの作者様にはこの場をお借りして感謝の意を記したいと思います。本記事を元にSwift3に書き直しを行いアレンジしました。<br>"
                    + "<strong>インスパイア記事:</strong><br><a href=\"https://developers.eure.jp/tech/zoom_animation/\">SwiftでiPhone標準写真アプリのアニメーションを再現してみる</a><br>"
                    + "(自作のAPIとの連携や機能やキャッシュ等に関しては年明け以降になんらかの形でまとめようと思います)",
                thumbnail: "paragraph2"
            )
        )
        paragraphModels.append(
            KanazawaPhotoArticleParagraph(
                paragraphTitle: "このサンプルの利用等に関して",
                paragraphSummary: "サンプルの使用やカスタマイズ・要望や不具合に関しましてのお問い合わせ先に関する記載になります。",
                paragraphText: "このサンプルに関しましてはどなた様でもご自由にご利用いただくことができます。改変や再配布に関しましてもご自由に行って頂けましたら幸いに思います。<br>"
                    + "本サンプルに関しての機能の追加及び改善のご相談やご要望・不具合やバグの報告に関しては私のGithubやこれから書く予定であるQiitaのコメント等で頂けましたら調査及び改善の対応を致します。<br>"
                    + "PullRequestやIssue等につきましてもお気軽にどうぞ！<br>"
                    + "<strong>Github:</strong><br><a href=\"https://github.com/fumiyasac/mediaStyleTableViewSet\">このサンプルのリポジトリが表示されます</a><br>"
                    + "<strong>Qiita:</strong><br><a href=\"http://qiita.com/fumiyasac@github\">Qiitaのページが表示されます</a><br>"
                    + "今後ともたくさん良いUI表現のショーケースを数多く提供できるように、そして一介のSwiftを操るエンジニアとしてさらに精進を重ねて少しでも参考になるものを提供できるようにする次第です。<br>"
                    + "※AdventCalendarの記事は今しばらくお待ちくださいませm(_ _)m",
                thumbnail: "paragraph3"
            )
        )

        return paragraphModels
    }
}
