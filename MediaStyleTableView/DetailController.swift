//
//  DetailController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UITableViewDelegate/*, UITableViewDataSource*/ {

    //画面遷移前に遷移元から渡される画像データを格納するメンバ変数
    var targetImageData: UIImage?

    //ヘッダー位置に配置したImageView
    @IBOutlet weak fileprivate var targetImageView: UIImageView!
    
    //記事のパラグラフを表示するテーブルビュー
    @IBOutlet weak var articleDetailTableView: UITableView!
    
    //メニューの代わりになるScrollView
    @IBOutlet weak var menuScrollView: UIScrollView!

    //メニューの代わりになるScrollViewの下の制約
    @IBOutlet weak var menuScrollViewBottomConstraint: NSLayoutConstraint!
    
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
        
        //TableViewのDelegate/DataSourceを設定する
        articleDetailTableView.delegate = self
        //articleDetailTableView.dataSource = self
        
        //初期状態ではScrollViewの制約を隠れる状態にしておく
        menuScrollViewBottomConstraint.constant = -menuScrollView.frame.height
    }
    
    //レイアウト処理が完了した際のライフサイクル
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //TODO: UIScrollViewへのボタン配置を行う（動くラベル付）
    }
    
    //imageViewの作成を行うメソッド ※UIViewControllerContextTransitioningで設定したアニメーション関連処理の際に使用する
    func createImageView() -> UIImageView? {
        
        //現在選択中の画像があるかを確認する
        guard let detailImageView = targetImageView else {
            return nil
        }
        
        //現在選択中のImageViewを取得する
        //動かすImageViewのプロパティは「contentMode → .scaleAspectFill, clipsToBounds → true」
        let imageView = UIImageView(image: targetImageData)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = detailImageView.frame
        return imageView
    }
    
    /* (UIScrollViewDelegate) */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
