//
//  ViewController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//ライブラリのインポート
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

enum NavigationStatus {
    case display
    case hidden
}

//カテゴリー名を格納しているEnum
enum CategoryName: String {
    case gourmet = "グルメ・お食事"
    case shopping = "ショッピング・お買い物"
    case tourism = "観光・街めぐり"
    case hotel = "ホテル・宿泊"
    case event = "イベント・催し物"
    
    //カテゴリーの表記から対応するWebカラーコードを返す
    static func getCategoryColor(category: String) -> String {
        
        switch category {

        case self.gourmet.rawValue:
            return WebColorList.gourmet.rawValue
        
        case self.shopping.rawValue:
            return WebColorList.shopping.rawValue
        
        case self.tourism.rawValue:
            return WebColorList.tourism.rawValue
        
        case self.hotel.rawValue:
            return WebColorList.hotel.rawValue
        
        case self.event.rawValue:
            return WebColorList.event.rawValue
        
        default:
            return WebColorList.lightGrayCode.rawValue
        }
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //選択したImageViewを格納するメンバ変数
    var selectedImageView: UIImageView?
    
    //記事用のCollectionView
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    //CollectionViewに表示するデータ格納用の変数
    var models: [KanazawaPhotoArticle] = []
    
    //ダミーのヘッダービューを設定する
    var headerBackgroundView: UIView = UIView(
        frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
    )
    
    //メニューボタンの属性値を決定する（※今回はあくまでデザイン上の仮置き）
    let attrsButton = [
        NSForegroundColorAttributeName : UIColor.gray,
        NSFontAttributeName : UIFont(name: "Georgia", size: 14)!
    ]
    
    //画面表示が開始された際のライフサイクル
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NavigationControllerのカスタマイズを行う(ナビゲーションを透明にする)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //StatusBar & NavigationBarの上書き用の背景を設定
        initializeDummyHeaderView()
        
        self.view.addSubview(headerBackgroundView)
        
        //collectionViewのdelegate/dataSourceの宣言
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        
        //タイトルの設定を空文字にする（NavigationControllerで引き継がれるのを防止する）
        navigationItem.title = ""
        
        //左メニューボタンの配置（※今回はあくまでデザイン上の仮置き）
        let leftMenuButton = UIBarButtonItem(title: "💫更新", style: .plain, target: self, action: #selector(ViewController.reloadButtonTapped(button:)))
        leftMenuButton.setTitleTextAttributes(attrsButton, for: .normal)
        navigationItem.leftBarButtonItem = leftMenuButton
        
        //右メニューボタンの配置（※今回はあくまでデザイン上の仮置き）
        let rightMenuButton = UIBarButtonItem(title: "🔖特集", style: .plain, target: self, action: #selector(ViewController.pickupButtonTapped(button:)))
        rightMenuButton.setTitleTextAttributes(attrsButton, for: .normal)
        navigationItem.rightBarButtonItem = rightMenuButton
        
        //表示用のモックデータを取得する
        //models = PhotoListMock.getArticlePhotoList()
        
        //表示用のAPIデータを設定する
        getPhotoArticleData()
    }

    /* (Instance Method) */
    
    //imageViewの作成を行うメソッド ※UIViewControllerContextTransitioningで設定したアニメーション関連処理の際に使用する
    func createImageView() -> UIImageView? {
        
        //現在選択中の画像があるかを確認する
        guard let selectedImageView = self.selectedImageView else {
            return nil
        }
        
        //現在選択中のImageViewを取得する
        //動かすImageViewのプロパティは「contentMode → .scaleAspectFit, clipsToBounds → true」
        let imageView = UIImageView(image: selectedImageView.image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.frame = selectedImageView.convert(selectedImageView.frame, to: self.view)
        return imageView
    }
    
    //リロードボタンタップ時のメソッド
    func reloadButtonTapped(button: UIButton) {
        getPhotoArticleData()
    }

    //ピックアップボタンタップ時のメソッド
    func pickupButtonTapped(button: UIButton) {

        //遷移元からポップアップ用のViewControllerのインスタンスを作成する
        let popupVC = UIStoryboard(name: "Popup", bundle: nil).instantiateViewController(withIdentifier: "PopupController") as! PopupController

        /**
         * ポップアップ用のViewConrollerを設定し、modalPresentationStyle(= .overCurrentContext)と背景色(= UIColor.clear)を設定する
         * 参考：XCode内で設定する場合は下記URLのように行うと一番簡単です
         * http://qiita.com/dondoko-susumu/items/7b48413f63a771484fbe
         */
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.view.backgroundColor = UIColor.clear

        //ポップアップ用のViewControllerへ遷移(遷移元のクラスで独自アニメーションを定義しているので第1引数:animatedをfalseにしておく）
        self.present(popupVC, animated: false, completion: nil)
    }

    /* (UICollectionViewDataSource) */
    
    //セクションのアイテム数を設定する
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    //セルに表示する値を設定する
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        //文字列データを読み込む
        let colorData: WebColorList = models[indexPath.row].themeColor
        let categoryData: CategoryName = models[indexPath.row].categoryName
        
        cell.titleLabel.text = models[indexPath.row].mainTitle
        cell.categoryLabel.backgroundColor = WebColorConverter.colorWithHexString(hex: colorData.rawValue)
        cell.categoryLabel.text = categoryData.rawValue
        
        //画像URLを取得する
        let image_url = URL(string: models[indexPath.row].mainImage)
        
        //表示時にフェードインするようなアニメーションをかける
        DispatchQueue.global().async {
            
            //画像をURLから読み込んでキャッシュさせる場合などはここに記載（サブスレッド）
            cell.cellImageView.sd_setImage(with: image_url)
            
            //表示するUIパーツは非表示にする
            cell.cellImageView.alpha = 0
            cell.titleLabel.alpha = 0
            cell.categoryLabel.alpha = 0

            //画面の更新はメインスレッドで行う
            DispatchQueue.main.async {
                
                //画像の準備が完了したらUIImageViewを表示する
                UIView.animate(withDuration: 0.64, delay: 0.26, options: UIViewAnimationOptions.curveEaseOut, animations:{
                    cell.cellImageView.alpha = 1
                    cell.titleLabel.alpha = 1
                    cell.categoryLabel.alpha = 1
                }, completion: nil)
            }
        }
        
        return cell
    }

    //セルが選択された際の処理を設定する
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //選択されたセルから遷移先のimageViewに渡すためのImageViewをメンバ変数へ格納する
        let cell = collectionView.cellForItem(at: indexPath) as! ArticleCell
        selectedImageView = cell.cellImageView
        
        //遷移先のStoryboard名とViewControllerに設定したIdentifierの値を元に遷移先のViewControllerを取得する
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailController") as! DetailController

        //遷移先のimageプロパティに選択した画像のUIImage型で画像データを渡す
        controller.targetImageData = selectedImageView?.image
        
        //Pushで遷移を行う（遷移の際にはTransitionControllerで定義したアニメーションが発動する）
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /* (UICollectionViewDelegateFlowLayout) */

    //セル名「ArticleCell」のサイズを返す
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //セルのサイズを返す（配置したUICollectionViewのセルの高さを合わせておく必要がある）
        return ArticleCell.cellOfSize()
    }
    
    //セルの垂直方向の余白(margin)を設定する
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    //セルの水平方向の余白(margin)を設定する
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    //セル内のアイテム間の余白(margin)調整を行う
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /* (UICollectionViewDataSource) */
    
    //スクロールが検知された時に実行される処理
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        //下方向のスクロールの際にはダミーのスクロールビューを隠す（逆の場合は表示する）
        if offsetY < 0 {

            UIView.animate(withDuration: 0.16, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {

                //ダミーのナビゲーションバーを表示する
                self.headerBackgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)

            }, completion: { finished in

                //アニメーション完了時にナビゲーションバーのボタンを再配置する
                let leftMenuButton = UIBarButtonItem(title: "💫更新", style: .plain, target: self, action: #selector(ViewController.reloadButtonTapped(button:)))
                leftMenuButton.setTitleTextAttributes(self.attrsButton, for: .normal)
                self.navigationItem.leftBarButtonItem = leftMenuButton
                
                let rightMenuButton = UIBarButtonItem(title: "🔖特集", style: .plain, target: self, action: #selector(ViewController.pickupButtonTapped(button:)))
                rightMenuButton.setTitleTextAttributes(self.attrsButton, for: .normal)
                self.navigationItem.rightBarButtonItem = rightMenuButton
            })
            
        } else {

            UIView.animate(withDuration: 0.16, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                //ダミーのナビゲーションバーを隠す
                self.headerBackgroundView.frame = CGRect(x: 0, y: -64, width: UIScreen.main.bounds.size.width, height: 64)

            }, completion: { finished in
                
                //アニメーション完了時にナビゲーションバーのボタンにnilを入れて空っぽの状態する
                self.navigationItem.leftBarButtonItem = nil
                self.navigationItem.rightBarButtonItem = nil
            })
        }
    }

    /* (Fileprivate Functions) */

    //Alamofire & SwiftyJSONでAPIからデータを取得する
    fileprivate func getPhotoArticleData() {
        
        //モデルデータを空にしてプログレスバーを表示する
        models.removeAll()
        SVProgressHUD.show(withStatus: "読み込み中...")
        
        //データ取得処理開始時はcollectionViewのタッチイベントを無効にする
        articleCollectionView.isUserInteractionEnabled = false

        //データ取得処理開始時は同様に左右のBarButtonItemも非活性にする
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        Alamofire.request("https://immense-journey-38002.herokuapp.com/articles.json").responseJSON { (responseData) -> Void in
            
            if let response = responseData.result.value {
                
                //JSONデータ取得する
                let jsonList = JSON(response)
                
                //JSONから取得したデータを解析してモデルに追加する
                if let results = jsonList["article"]["contents"].arrayObject {
                    
                    let resultLists = results as! [[String : AnyObject]]
                    
                    for i in 0...(resultLists.count - 1) {
                        
                        //取得結果をDictionary型へ変換する
                        let result = resultLists[i] as Dictionary
                        
                        //セルで使用する値の一覧を取得する
                        let title = result["title"] as! String
                        let image_url = result["image_url"] as! String
                        let category = result["category"] as! String
                        let color = CategoryName.getCategoryColor(category: category)
                        
                        //モデルクラスのデータに順次追加をしていく
                        self.models.append(
                            KanazawaPhotoArticle(
                                mainTitle: title,
                                mainImage: image_url,
                                categoryName: CategoryName(rawValue: category)!,
                                themeColor: WebColorList(rawValue: color)!
                            )
                        )
                    }
                }
                
                //JSONからデータを取得しデータのセットが完了したらプログレスバーを消す（今回は0になることはないが本来は考慮はすべき）
                SVProgressHUD.dismiss()
                if self.models.count > 0 {
                    self.articleCollectionView.reloadData()
                }
                
            } else {
                
                //エラーのハンドリングを行う
                SVProgressHUD.dismiss()
                let errorAlert = UIAlertController(
                    title: "通信状態エラー",
                    message: "データの取得に失敗しました。通信状態の良い場所ないしはお持ちのWiftに接続した状態で再度更新ボタンを押してお試し下さい。",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                errorAlert.addAction(
                    UIAlertAction(
                        title: "OK",
                        style: UIAlertActionStyle.default,
                        handler: nil
                    )
                )
                self.present(errorAlert, animated: true, completion: nil)
            }
            
            //データ取得が終了したらcollectionViewのタッチイベントを有効にする
            self.articleCollectionView.isUserInteractionEnabled = true

            //データ取得が終了したら同様に左右のBarButtonItemも活性にする
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
    }
    
    
    //ダミー用のヘッダービューの内容を設定する
    fileprivate func initializeDummyHeaderView() {
        
        //背景の配色や線に関する設定を行う
        headerBackgroundView.backgroundColor = UIColor.white
        headerBackgroundView.layer.borderWidth = 1
        headerBackgroundView.layer.borderColor = WebColorConverter.colorWithHexString(hex: WebColorList.lightGrayCode.rawValue).cgColor
        
        //タイトルのラベルを作成してダミーのヘッダービューに追加する
        let dummyTitle: UILabel! = UILabel()
        dummyTitle.font = UIFont(name: "Georgia-Bold", size: 14)!
        dummyTitle.text = "石川の写真周遊録"
        dummyTitle.textColor = UIColor.black
        dummyTitle.textAlignment = NSTextAlignment.center
        dummyTitle.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 44)
        headerBackgroundView.addSubview(dummyTitle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

