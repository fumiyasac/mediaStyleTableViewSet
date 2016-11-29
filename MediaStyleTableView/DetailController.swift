//
//  DetailController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/28.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    var image: UIImage?
    
    //ヘッダー位置に配置したImageView
    @IBOutlet fileprivate weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: NavigationControllerのカスタマイズを行う
    }

    //imageViewの作成を行うメソッド ※UIViewControllerContextTransitioningで設定したアニメーション関連処理の際に使用する
    func createImageView() -> UIImageView? {
        
        guard let detailImageView = self.imageView else {
            return nil
        }
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = detailImageView.frame
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
