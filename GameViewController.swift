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
    
    var positionX:[CGFloat]=[0.0,0.0,0.0]//画像の位置の配列
    
    var dx:[CGFloat]=[1.0,0.5,-1.0]//画像の動かす幅の配列

    override func viewDidLoad() {
        super.viewDidLoad()
        positionX=[width/2,width/2,width/2]//画像の位置を画面幅の中心にする
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
            if positionX[i]>width || positionX[i]<0{
                dx[i]=dx[i]*(-1)
            }
            positionX[i]+=dx[i]//画像の位置をdx分ずらす
        }
        imgView1.center.x=positionX[0]//上の画像をずらした位置に移動
        imgView2.center.x=positionX[1]//真ん中の画像をずらした位置に移動
        imgView3.center.x=positionX[2]
    }
    
//ストップ機能
    @IBAction func stop(){
        if timer.valid==true{//もしタイマーが動いていたら
            timer.invalidate()//タイマーを止める
        }
        
        for i in 0..<3 {
            //画像ずれた分だけスコアから値をひく
            score = score-abs(Int(width/2 - positionX[i]))*2
        }
        resultLabel.text = "Score:" + String(score) //結果ラベルにスコア表示
        resultLabel.hidden = false //結果ラベルを隠さない
    
        var highScore1: Int = defaults.integerForKey("score1") //ユーザーデフォルトに"score1"というキーの値を取得
        var highScore2: Int = defaults.integerForKey("score2") //"score2"というキーの値を取得
        var highScore3: Int = defaults.integerForKey("score3") //"score3"というキーの値を取得
        
        if score > highScore1 { //ランキング1位の記録を更新したら
            defaults.setInteger(score, forKey:"score1") //"score1"というキーでscoreを保存
            defaults.setInteger(highScore1, forKey:"score2") //"score2"というキーでhighScore1(元1位)を保存
            defaults.setInteger(highScore2, forKey:"score3") //"score3"というキーでhighScore2(元2位)を保存
        }else if score > highScore2 { //ランキング2位の記録を更新したら
            defaults.setInteger(score, forKey:"score2")
            defaults.setInteger(highScore2, forKey:"score3")
        }else if score > highScore3 { //ランキング2位の記録を更新したら
            defaults.setInteger(score, forKey:"score3")
        }
        defaults.synchronize()
    }

//リトライ機能
    @IBAction func retry(){
        score = 1000 //スコアリセット
        positionX = [width/2, width/2, width/2] //画像の位置を真ん中に
        self.start() //スタートメソッド呼び出し
    }

//トップへ
    @IBAction func toTop(){
        self.dismissViewControllerAnimated(true, completion: nil)
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