//
//  ViewController.swift
//  T2_P_ImageDownload
//
//  Created by 寺先生 on 2018/12/27.
//  Copyright © 2018 wu yuansi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView加上点击手势
//        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
//        imageView?.addGestureRecognizer(singleTapGesture)
//        imageView?.isUserInteractionEnabled = true
        
        //长按手势
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.addGestureRecognizer(longTapGesture)
        imageView.isUserInteractionEnabled = true
        
        //初始化imageVIew
        let url = "http://img.jandan.net/news/2018/12/b43e3aa1d06054f435f8abc5fec40938.jpg"
            imageView.downloadedFrom(imageUrl: url)
        
    }

    @objc func imageViewClick(){
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let save = UIAlertAction(title: "保存", style: UIAlertAction.Style.default) { [weak self] (_) in
        //保存图片到相册 这里是要使用弱引用 因为使用了self, 保存后使用回调函数进行通知
        UIImageWriteToSavedPhotosAlbum(self!.imageView.image!, self!, #selector(self!.image), nil)
        
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil);
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    //保存二维码
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "保存成功", message: "请打开微信识别二维码关注", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }

}


extension UIImageView{
    func downloadedFrom(imageUrl : String){
        //创建URL对象
        let url = URL(string: imageUrl)!
        //创建请求对象
        let request = URLRequest(url: url)

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)

                // 这里需要改UI，需要回到主线程
                DispatchQueue.main.async {
                    self.image = img
                }

            }
        }) as URLSessionTask

        //使用resume方法启动任务
        dataTask.resume()
    }

}
