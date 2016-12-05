//
//  PopupController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/12/05.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class PopupController: UIViewController {

    //UIパーツの配置
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupCloseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンやポップアップ表示部分を角丸デザインに変更する
        popupView.layer.cornerRadius = 5.0
        popupCloseButton.layer.cornerRadius = 20.0
        
        //初回呼び出し時にはコンテンツ全体を非表示状態にしておく
        self.view.alpha = 0.0
        
        //参考：初期化処理等は平素通りに行う
    }
    
    //Viewの表示が完了した際に呼び出されるメソッド
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //ポップアップ表示を実行する
        showAnimatePopup()
    }
    
    //ポップアップを閉じるボタンアクション
    @IBAction func closePopupAction(_ sender: UIButton) {

        //ポップアップ削除を実行する
        removeAnimatePopup()
    }
    
    /* (Fileprivate functions) */
    
   fileprivate func showAnimatePopup() {
        self.view.transform = CGAffineTransform(scaleX: 1.38, y: 1.38)
        UIView.animate(withDuration: 0.16, animations: {
            
            //おおもとのViewのアルファ値を1.0にして拡大比率を元に戻す
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
   fileprivate func removeAnimatePopup() {
        UIView.animate(withDuration: 0.16, animations: {

            //おおもとのViewのアルファ値を0.0にして拡大比率を拡大した状態に変更
            self.view.transform = CGAffineTransform(scaleX: 1.38, y: 1.38)
            self.view.alpha = 0.0

        }, completion:{ finished in
            
            //アニメーションが完了した際に元の画面に戻す（独自アニメーションを定義しているので第1引数:animatedをfalseにしておく）
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
