//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by takafumi oosugi on 2016/02/10.
//  Copyright © 2016年 myname. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var imgView1: UIImageView! //上の画像
    @IBOutlet var imgView2: UIImageView! //真ん中の画像
    @IBOutlet var imgView3: UIImageView! //下の画像
    @IBOutlet var resultLabel: UILabel! //スコアを表示するラベル
    
    var timer:NSTimer!//画像を動かすためのタイマー
    var score:Int=1000//スコアの値
    let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()//スコア保存の変数
    
    let width:CGFloat=UIScreen.mainScreen().bounds.size.width//画面幅
    
    var potitionX:[CGFloat]=[0.0,0.0,0.0]//画像の位置の配列
    
    var dx:[CGFloat]=[1.0,0.5,-1.0]//画像の動かす幅の配列

    override func viewDidLoad() {
        super.viewDidLoad()
        potitionX=[width/2,width/2,width/2]//画像の位置を画面幅の中心にする
        self.start()//startメソッド呼び出し

        // Do any additional setup after loading the view.
    }

    func start(){
        //結果ラベルを隠す
        resultLabel.hidden=true
        
        //タイマーを動かす
        timer=NSTimer.scheduledTimerWithTimeInterval(0.005,target:self,selector:"up",userInfo:nil,repeats:true)
        timer.fire()
    }
    
    
    func up(){
        for i in 0..<3{
            //端に来たら向きを逆に
            if potitionX[i]>width || potitionX[i]<0{
                dx[i]=dx[i]*(-1)
            }
            potitionX[i]+=dx[i]//画像の位置をdx分ずらす
        }
        imgView1.center.x=potitionX[0]//上の画像をずらした位置に移動
        imgView2.center.x=potitionX[1]//真ん中の画像をずらした位置に移動
        imgView3.center.x=potitionX[2]
    }
    
    @IBAction func stop(){
        if timer.valid==true{//もしタイマーが動いていたら
            timer.invalidate()//タイマーを止める
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}