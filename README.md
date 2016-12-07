MediaStyleTableViewSet
[ING] ECやメディア系のアプリでよくある遷移時のカスタムトランジションやアニメーションを活用した「写真を生かすUI」のサンプル（iOS Sample Study: Swift）

EC系やメディア系のアプリの多くでは「写真を生かしたレイアウトや心地よいアニメーション」がUIの随所に散りばめられていてなおかつ綺麗にまとまった形になっているものを多く見受けるます。本サンプルは

##### 実装機能一覧

本サンプル内で実装している機能の一覧は下記になります。

+ UICollectionViewCellのタップ時にUIViewControllerAnimatedTransitioningを活用した画面遷移処理を用いて、画像を拡大させて遷移先のUIViewControllerを表示する動き
+ 遷移先から戻る際も同様にUIViewControllerAnimatedTransitioningを活用した画面遷移処理を用いて、遷移元のUICollectionViewの画像表示エリアに画像を戻す動き
+ SwiftyJSON & Alamofireを利用したAPI通信
+ カスタムしたポップアップの表示
+ アニメーションとスレッド・画像キャッシュをうまく活用した画像読み込み
+ UINavigationControllerのデザインカスタマイズと設定に関する部分
+ UITextView部分のHTMLタグの有効化
+ ボタンに設定した下線が押下のタイミングで文字幅に合わせてた位置に移動
+ その他スクロール時のアニメーション

##### 本サンプルの画面キャプチャ

__キャプチャ画像その1：__

![sample_capture1.jpg](https://qiita-image-store.s3.amazonaws.com/0/17400/1f2527c6-0eeb-101b-2c38-23fa724606ff.jpeg)

__キャプチャ画像その2：__

![sample_capture2.jpg](https://qiita-image-store.s3.amazonaws.com/0/17400/2fbbc6fd-3e00-6c1e-8846-7522e6214b39.jpeg)

##### UIViewControllerAnimatedTransitioningを活用して画像を拡大させて遷移先のUIViewControllerを表示する処理に関する設計図、実装の際の参考にして頂けますと幸いです。

UIViewControllerAnimatedTransitioningを活用した、画面遷移の際に画面全体がフェードイン・アウトと同時に画像の拡大・縮小を伴う動きを実装しています。Push(進む)及びPop(戻る)遷移が行われる際のアニメーションに関する設計を自分なりにまとめましたので

__参考1. 平面図：__

![customtransion.JPG](https://qiita-image-store.s3.amazonaws.com/0/17400/43ed31f0-3718-c735-0c47-ad2830d44dff.jpeg)

__参考2. 展開図：__

![transition2.jpg](https://qiita-image-store.s3.amazonaws.com/0/17400/817bd403-dc5e-4aed-18ef-caa960030648.jpeg)

##### 写真一覧画面のNavigationBarのカスタマイズに関する設計図

本サンプルではUINavigationBarを透明な状態にしている関係上、NavigationBarの下にダミーのUIViewを入れる実装を行っています。写真の一覧画面(ViewController.swift)におけるヘッダー部分の各パーツの重なり方の展開図は下記になりますので、実装の際の参考にして頂けますと幸いです。

__参考. 展開図：__

![navigationcontroller.jpg](https://qiita-image-store.s3.amazonaws.com/0/17400/e32593c9-441f-7219-bbe9-f26f28ba099d.jpeg)

##### 使用ライブラリ

UIまわりの実装と直接関係のない部分に関しては、下記のライブラリを使用しました。

+ [SVProgressHUD(データ読み込み時のプリローダー表示)](https://github.com/SVProgressHUD/SVProgressHUD)
+ [SwiftyJSON(JSONデータの解析をしやすくする)](https://github.com/SwiftyJSON/SwiftyJSON)
+ [Alamofire(HTTPないしはHTTPSのネットワーク通信用)](https://github.com/Alamofire/Alamofire)
+ [SDWebImage(画像URLからの非同期での画像表示とキャッシュサポート)](https://github.com/rs/SDWebImage)

##### 参考記事

下記の記事及びサンプルを参考にしてSwift3.0.1で書き直し及びアレンジを加えて本サンプルを作成しました。
この場をお借り致しましてお礼申し上げます。ありがとうございました。

+ [画像がズームインしながら画面遷移するSwiftライブラリを公開しました](http://qiita.com/WorldDownTown/items/2ffe6324689533745373)
+ [SwiftでiPhone標準写真アプリのアニメーションを再現してみる](https://developers.eure.jp/tech/zoom_animation/)


