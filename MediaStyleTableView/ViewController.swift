//
//  ViewController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var photos = [UIImage]()

    //選択したImageViewを格納するメンバ変数
    var selectedImageView: UIImageView?
    
    //記事用のCollectionView
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionViewのdelegate/dataSourceの宣言
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
    }

    /* (Instance Method) */
    
    //imageViewの作成を行うメソッド ※UIViewControllerContextTransitioningで設定したアニメーション関連処理の際に使用する
    func createImageView() -> UIImageView? {
        
        //現在選択中の画像があるかを確認する
        guard let selectedImageView = self.selectedImageView else {
            return nil
        }
        
        //現在選択中のImageViewを取得する
        let imageView = UIImageView(image: selectedImageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = selectedImageView.convert(selectedImageView.frame, to: self.view)
        return imageView
    }

    /* (UICollectionViewDataSource) */
    
    //セクションのアイテム数を設定する
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    //セルに表示する値を設定する
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        return cell
    }

    //セルが選択された際の処理を設定する
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //選択されたセルから遷移先のimageViewに渡すためのImageViewをメンバ変数へ格納する
        let cell = collectionView.cellForItem(at: indexPath) as! ArticleCell
        selectedImageView = cell.cellImageView
        
        //遷移先のStoryboard名とViewControllerに設定したIdentifierの値を元に遷移先のViewControllerを取得する
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailController") as! DetailController

        //遷移先のimageプロパティに選択した画像のUIImage型で画像データを渡す
        controller.image = selectedImageView?.image
        
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
    internal internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

