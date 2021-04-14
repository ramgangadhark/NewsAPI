//
//  TableViewNewsViewController.swift
//  KwikMartProject
//
//  Created by Ram on 10/04/21.
//

import UIKit

class TableViewNewsViewController: UIViewController {

    @IBOutlet weak var newsImgView: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var newsLbl: UILabel!
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleGestureRecogniser()
        // Do any additional setup after loading the view.
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
