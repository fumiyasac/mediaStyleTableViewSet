//
//  DetailController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    //画面遷移前に遷移元から渡される画像データを格納するメンバ変数
    var targetImageData: UIImage?

    //ヘッダー位置に配置したImageView
    @IBOutlet fileprivate weak var targetImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: NavigationControllerのカスタマイズを行う
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
