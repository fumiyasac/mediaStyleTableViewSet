//
//  ViewController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//カテゴリー名を格納しているEnum
enum CategoryName: String {
    case gourmet = "グルメ・お食事"
    case shopping = "ショッピング・お買い物"
    case tourism = "観光・街めぐり"
    case hotel = "ホテル・宿泊"
    case event = "イベント・催し物"
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {

    //選択したImageViewを格納するメンバ変数
    var selectedImageView: UIImageView?
    
    //セクション内のセル数
    fileprivate let rowsInSectionCount = 12
    
    //記事用のCollectionView
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //StatusBar & NavigationBarの上書き用の背景を設定
        let headerBackgroundView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
        headerBackgroundView.backgroundColor = UIColor.white
        headerBackgroundView.layer.borderWidth = 1
        headerBackgroundView.layer.borderColor = WebColorConverter.colorWithHexString(hex: WebColorList.lightGrayCode.rawValue).cgColor
        
        self.view.addSubview(headerBackgroundView)
        
        //collectionViewのdelegate/dataSourceの宣言
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        
        //タイトル用の色および書式の設定
        navigationItem.title = "金沢の風景アーカイブ"
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

    /* (UICollectionViewDataSource) */
    
    //セクションのアイテム数を設定する
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowsInSectionCount
    }
    
    //セルに表示する値を設定する
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        //表示時にフェードインするようなアニメーションをかける
        DispatchQueue.global().async {
            
            //TODO: 画像をURLから読み込んでキャッシュさせる場合などはここに記載（サブスレッド）
            
            //表示するUIパーツは非表示にする
            cell.cellImageView.alpha = 0
            cell.titleLabel.alpha = 0
            cell.categoryLabel.alpha = 0

            //画面の更新はメインスレッドで行う
            DispatchQueue.main.async {
                
                //画像の準備が完了したらUIImageViewを表示する
                UIView.animate(withDuration: 0.64, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations:{
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

