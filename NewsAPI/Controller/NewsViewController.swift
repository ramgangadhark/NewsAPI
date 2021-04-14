//
//  NewsViewController.swift
//  KwikMartProject
//
//  Created by Ram on 05/04/21.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var NewsImgView: UIImageView!
    var author:String = ""
    var news:String = ""
    @IBOutlet weak var AuthorLbl: UILabel!
    @IBOutlet weak var NewsLbl: UILabel!
    var url:String = ""
    var imgUrl:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleGestureRecogniser()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        AuthorLbl.text = author
        NewsLbl.text = news
        if(imgUrl == "NoImage")
        {
            NewsImgView.image = UIImage(named: "NoImage")
        }else
        {
            do{
                NewsImgView.image = try UIImage(data: Data(contentsOf: URL(string: imgUrl)!))
            }catch
            {
                print("Error while loading image")
            }
        }
        
        
    }
    func handleGestureRecogniser(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
        
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
                let NWVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NWVC") as! NewsWebViewViewController
                NWVC.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(NWVC, animated: true, completion: {
                    NWVC.newsUrl = self.url
                })
               
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}
