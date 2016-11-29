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

    //現在選択中のimageView
    var selectedImageView: UIImageView?
    
    //記事用のcollectionView
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionViewのdelegate/dataSourceの宣言
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
    }

    /* (Instance Method) */
    
    //imageViewの作成を行うメソッド ※アニメーション関連処理の際に使用する
    func createImageView() -> UIImageView? {
        
        //現在選択中の画像があるかを確認する
        guard let selectedImageView = self.selectedImageView else {
            return nil
        }
        
        //現在選択中のimageViewを取得する
        let imageView = UIImageView(image: selectedImageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = selectedImageView.convert(selectedImageView.frame, to: self.view)
        return imageView
    }

    /* (UICollectionViewDataSource) */
    
    //セクションのアイテム数を設定する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    //セルに表示する値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        return cell
    }

    //セルに表示する値を設定する
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ArticleCell
        self.selectedImageView = cell.cellImageView
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        
        controller.image = self.selectedImageView?.image
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /* (UICollectionViewDelegateFlowLayout) */

    //セル名「ArticleCell」のサイズを返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ArticleCell.cellOfSize()
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    //セル間の余白調整を行う
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

