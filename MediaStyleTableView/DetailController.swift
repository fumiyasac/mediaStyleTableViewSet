//
//  DetailController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//ボタンに表示する文言のリスト
struct ScrollButtonList {
    static let buttonList: [String] = [
        "Menu1",
        "Menu2",
        "Menu3"
    ]
}

//スライドメニューの位置
struct SlideMenuSetting {
    static let movingLabelY = 0
    static let movingLabelH = 3
}

class DetailController: UIViewController, UITableViewDelegate/*, UITableViewDataSource*/ {

    //画面遷移前に遷移元から渡される画像データを格納するメンバ変数
    var targetImageData: UIImage?

    //ヘッダー位置に配置したImageView
    @IBOutlet weak fileprivate var targetImageView: UIImageView!
    
    //記事のパラグラフを表示するテーブルビュー
    @IBOutlet weak var articleDetailTableView: UITableView!
    
    //セクション数
    fileprivate let sectionCount = 3
    
    //セクション内のセル数
    fileprivate let rowsInSectionCount = 1
    
    //メニューの代わりになるScrollView
    @IBOutlet weak var menuScrollView: UIScrollView!

    //メニューの代わりになるScrollViewの下の制約
    @IBOutlet weak var menuScrollViewBottomConstraint: NSLayoutConstraint!
    
    //テーブルビューのスクロールの開始位置を格納する変数
    fileprivate var scrollBeginingPoint: CGPoint!
    
    //スクロールビュー内のボタンを一度だけ生成するフラグ
    fileprivate var layoutOnceFlag: Bool = false
    
    //スクロール内の動くラベル
    fileprivate let movingLabel = UILabel()
    
    //ボタンスクロール時の移動量
    fileprivate var scrollButtonOffsetX: Int!
    
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
        
        //セルの高さの予測値を設定する（高さが可変になる場合のセルが存在する場合）
        articleDetailTableView.rowHeight = UITableViewAutomaticDimension
        articleDetailTableView.estimatedRowHeight = 100000
        
        //初期状態ではScrollViewの制約を隠れる状態にしておく
        menuScrollViewBottomConstraint.constant = -menuScrollView.frame.height
    }
    
    //レイアウト処理が完了した際のライフサイクル
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //UIScrollViewへのボタン配置を行う（動くラベル付）
        //※AutoLayoutのConstraintを用いたアニメーションの際には動的に配置する見た目要素は一度だけ実行する
        if layoutOnceFlag == false {
            
            //コンテンツ用のScrollViewを初期化
            initScrollViewDefinition()
            
            //スクロールビュー内のサイズを決定する（AutoLayoutで配置を行った場合でもこの部分はコードで設定しないといけない）
            menuScrollView.contentSize = CGSize(
                width: CGFloat(Int(menuScrollView.frame.width / 3) * ScrollButtonList.buttonList.count),
                height: menuScrollView.frame.height
            )
            
            //メインのスクロールビューの中にコンテンツ表示用のコンテナを一列に並べて配置する
            for i in 0...(ScrollButtonList.buttonList.count - 1) {
                
                //メニュー用のスクロールビューにボタンを配置
                let buttonElement: UIButton! = UIButton()
                menuScrollView.addSubview(buttonElement)
                
                buttonElement.frame = CGRect(
                    x: CGFloat(Int(menuScrollView.frame.width) / 3 * i),
                    y: 0,
                    width: menuScrollView.frame.width / 3,
                    height: menuScrollView.frame.height
                )
                buttonElement.backgroundColor = UIColor.clear
                buttonElement.setTitle(ScrollButtonList.buttonList[i], for: UIControlState())
                buttonElement.setTitleColor(UIColor.gray, for: UIControlState())
                buttonElement.titleLabel!.font = UIFont(name: "Georgia-Bold", size: 11)!
                buttonElement.tag = i
                buttonElement.addTarget(self, action: #selector(DetailController.scrollButtonTapped(button:)), for: .touchUpInside)
            }
            
            //動くラベルの配置
            menuScrollView.addSubview(movingLabel)
            menuScrollView.bringSubview(toFront: movingLabel)
            movingLabel.frame = CGRect(
                x: 0,
                y: SlideMenuSetting.movingLabelY,
                width: Int(self.view.frame.width / 3),
                height: SlideMenuSetting.movingLabelH
            )
            movingLabel.backgroundColor = UIColor.gray
            
            //一度だけ実行するフラグを有効化
            layoutOnceFlag = true
        }
    }
    
    /* (Instance Methods) */
    
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
    
    //ボタンをタップした際に行われる処理
    func scrollButtonTapped(button: UIButton) {
        
        //押されたボタンのタグを取得
        let page: Int = button.tag
        
        //コンテンツを押されたボタンに応じて移動する
        moveToCurrentButtonLabelButtonTapped(page: page)
        //moveFormNowButtonContentsScrollView(page: page)
    }
    
    /* (UIScrollViewDelegate) */

    /* (fileprivate functions) */
    
    //コンテンツ用のUIScrollViewの初期化を行う
    fileprivate func initScrollViewDefinition() {
        
        //（重要）MainContentsControllerの「Adjust Scroll View Insets」のチェックを外しておく
        //スクロールビュー内の各プロパティ値を設定する
        //※注意: 今回は配置したボタン押下時の位置補正をするだけなので、このUIScrollViewに対してのUIScrollViewDelegateの処理はない
        menuScrollView.isPagingEnabled = false
        menuScrollView.isScrollEnabled = true
        menuScrollView.isDirectionalLockEnabled = false
        menuScrollView.showsHorizontalScrollIndicator = false
        menuScrollView.showsVerticalScrollIndicator = false
        menuScrollView.bounces = false
        menuScrollView.scrollsToTop = false
    }
    
    //ボタンタップ時に動くラベルをスライドさせる
    fileprivate func moveToCurrentButtonLabelButtonTapped(page: Int) {
        
        UIView.animate(withDuration: 0.26, delay: 0, options: [], animations: {
            
            self.movingLabel.frame = CGRect(
                x: Int(self.view.frame.width) / 3 * page,
                y: SlideMenuSetting.movingLabelY,
                width: Int(self.view.frame.width) / 3,
                height: SlideMenuSetting.movingLabelH
            )
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
