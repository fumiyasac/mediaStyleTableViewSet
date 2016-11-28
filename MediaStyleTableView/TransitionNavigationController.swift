//
//  TransitionNavigationController.swift
//  MediaStyleTableView
//
//  Created by 酒井文也 on 2016/11/29.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

/**
 * デフォルトのUINavigationControllerのアニメーション(push / pop)の挙動に独自アニメーションを付与する
 * → TransitionControllerクラスに置き換えるためのクラス
 * 参考：https://developers.eure.jp/tech/zoom_animation/
 * （注）解説とソースを参考にSwift3に置換して実装をしています。
 */
class TransitionNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationControllerのデリゲートを付与する
        self.delegate = self
    }

    //UINavigationControllerでUIViewControllerAnimatedTransitioningを実装した独自アニメーションを使用する際に使用する
    internal func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //TransitionControllerのインスタンスを作成する
        let transitionController = TransitionController()
        
        //操作のenum(TransitionController内で定義)の値に応じてpushかpopかを決定する
        switch operation {
        case .push:
            transitionController.forward = true
            return transitionController
        case .pop:
            transitionController.forward = false
            return transitionController
        default:
            break
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
