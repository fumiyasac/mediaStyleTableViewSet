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
        
        guard let selectedImageView = self.selectedImageView else {
            return nil
        }
        
        //現在選択中のimageViewを取得する
        let imageView = UIImageView(image: selectedImageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = selectedImageView.convert(selectedImageView.frame, to: self.view)
        return imageView
    }
    
    
    /* (UICollectionViewDelegateFlowLayout) */
    
    //セル間の余白調整を行う
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1.5, left: 1.5, bottom: 1.5, right: 1.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

