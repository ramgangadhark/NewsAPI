//
//  ViewController.swift
//  KwikMartProject
//
//  Created by Ram on 03/04/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK:- Global Variable Declaration
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var mainView1: UIView!
    @IBOutlet weak var sideViewWidthAnchor: NSLayoutConstraint!
    @IBOutlet weak var mainView1TrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var mainView1LeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var sideViewLeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var countryImage:UIImageView!
    var activeCases:UILabel!
    var totalCases:UILabel!
    var countryName:UILabel!
    var todayCases:UILabel!
    var mainTableView:UITableView!
    var newsCollectionView:UICollectionView!
    var isSideViewShowing = false
    var newsDataDictionary:NSDictionary?
    var authorArray:Array = [Any]()
    var titleArray:Array = [Any]()
    var urlArray:Array = [Any]()
    var descriptionArray:Array = [Any]()
    var imgURLArray:Array = [Any]()
    var contentArray:Array = [Any]()
    var btn:UIButton!
    var menuView:UIView!
    var isMenuViewShowing = false
    var countryInfo:[String:Any]?
    var covidInfo:[String:Any]?
    var covidArray:NSArray?
    var isSegmentSelected:Bool = true
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCall()
        createCollectionView()
        createTableView()
        createButton()
        
    }
    //MARK:- NewsAPI Call
    func ApiCall(){
        NetworkManager.shared.APICall { (Data, Err) in
            if(Err != nil){
                print(Err!)
            }
            else{
                //print(Data as Any)
                for i in 0..<Data!.count
                {
                    self.newsDataDictionary = ((Data![i]) as! NSDictionary)
                    //print(self.newsDataDictionary!["author"]!)
                    self.authorArray.append(self.newsDataDictionary!["author"]!)
                    self.titleArray.append(self.newsDataDictionary!["title"]!)
                    self.descriptionArray.append(self.newsDataDictionary!["description"]!)
                    self.urlArray.append(self.newsDataDictionary!["url"]!)
                    self.imgURLArray.append(self.newsDataDictionary!["urlToImage"]!)
                    self.contentArray.append(self.newsDataDictionary!["content"]!)
                    print(self.newsDataDictionary!["urlToImage"]!)
                }
                
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    self.newsCollectionView.reloadData()
                   // print(self.imgURLArray)
                }
                
            }
        }
    }
    //MARK:- Creating UI Button
    func createButton(){
        btn = UIButton()
        btn.frame = CGRect(x: 300, y: 700, width: 100, height: 35)
        btn.setTitle("Covid Alert", for: UIControl.State.normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        mainView1.addSubview(btn)
        btn.addTarget(self, action:  #selector(onClickOfBtn), for: UIControl.Event.touchUpInside)
        creatingMenuView()
        menuView.isHidden = true
        isMenuViewShowing = true
    }
    //MARK:- Covid Button Action
    @objc func onClickOfBtn()
    {
        if (isMenuViewShowing == true) {
            menuView.isHidden = false
           
            countryImage = UIImageView()
            countryImage.frame = CGRect(x: 25, y: 25, width: 250, height: 140)
            menuView.addSubview(countryImage)
            countryName = UILabel()
            countryName.frame = CGRect(x: 25, y: 170, width: 250, height: 40)
            countryName.font = UIFont.boldSystemFont(ofSize: 16)
            countryName.backgroundColor = #colorLiteral(red: 0.9180471301, green: 0.5697929263, blue: 0.1973303556, alpha: 1)
            countryName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            menuView.addSubview(countryName)
            todayCases = UILabel()
            todayCases.frame = CGRect(x: 25, y: 225, width: 250, height: 40)
            todayCases.font = UIFont.boldSystemFont(ofSize: 16)
            todayCases.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            todayCases.textColor = #colorLiteral(red: 0.1884154975, green: 0.2232014239, blue: 0.5997007489, alpha: 1)
            menuView.addSubview(todayCases)
            activeCases = UILabel()
            activeCases.frame = CGRect(x: 25, y: 285, width: 250, height: 40)
            activeCases.font = UIFont.boldSystemFont(ofSize: 16)
            activeCases.backgroundColor = #colorLiteral(red: 0.9998918176, green: 1, blue: 0.9998809695, alpha: 1)
            activeCases.textColor = #colorLiteral(red: 0.0822102949, green: 0.1903048158, blue: 0.5293337107, alpha: 1)
            menuView.addSubview(activeCases)
            totalCases = UILabel()
            totalCases.frame = CGRect(x: 25, y: 345, width: 250, height: 40)
            totalCases.backgroundColor = #colorLiteral(red: 0.2320346534, green: 0.5217760205, blue: 0.04774210602, alpha: 1)
            totalCases.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            totalCases.font = UIFont.boldSystemFont(ofSize: 16)
            menuView.addSubview(totalCases)
            totalCases.text = "Total Cases : \(NetworkManager.shared.covidData["cases"]!)"
            activeCases.text = "Active Cases : \(NetworkManager.shared.covidData["active"]!)"
            countryName.text = "Country : \(NetworkManager.shared.covidData["country"]!)"
            todayCases.text = "Today Cases : \(NetworkManager.shared.covidData["todayCases"]!)"
            do{
                self.countryImage.image = try UIImage(data: Data(contentsOf: URL(string: NetworkManager.shared.countryData!["flag"] as! String)!))
            }catch
            {
                print("Error while getting Image")
            }
            print(NetworkManager.shared.covidData["cases"]!)
            print(NetworkManager.shared.countryData!["flag"] as! String)
            btn.setTitle("Close", for: UIControl.State.normal)
            
            
        }else{
            btn.setTitle("Covid Alert", for: UIControl.State.normal)
            menuView.isHidden = true
        }
        isMenuViewShowing = !isMenuViewShowing
    }
    func creatingMenuView()
    {
        menuView = UIView()
        menuView.frame = CGRect(x: 120, y: 275, width: 300, height: 400)
        menuView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        menuView.clipsToBounds = true
        menuView.layer.cornerRadius = 12
        mainView1.addSubview(menuView)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(isSegmentSelected == true)
        {
            let off = self.mainTableView.contentOffset.y
            btn.frame = CGRect(x: 300, y: off + 730, width: btn.frame.width, height: btn.frame.height)
            menuView.frame = CGRect(x: 120, y: off + 275, width: menuView.frame.width, height: menuView.frame.height)
        }else
        {
            let off = self.newsCollectionView.contentOffset.y
            btn.frame = CGRect(x: 300, y: off + 730, width: btn.frame.width, height: btn.frame.height)
            menuView.frame = CGRect(x: 120, y: off + 275, width: menuView.frame.width, height: menuView.frame.height)
        }
    }
    //MARK:- Segmented Control Button Action
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            isSegmentSelected = true
            mainTableView.isHidden = false
            newsCollectionView.isHidden = true
            
            
            print("TableView")
        case 1:
            isSegmentSelected = false
            mainTableView.isHidden = true
            newsCollectionView.isHidden = false

            print("CollectionView")
            
        default:
            break
        }
    }
    //MARK:- Create CollectionView
    
    func createCollectionView()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        newsCollectionView = UICollectionView(frame: self.mainView1.frame, collectionViewLayout: layout)
        newsCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        newsCollectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        
        newsCollectionView.register(UINib(nibName: "PlaceHolderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaceHolderCollectionViewCell")
        newsCollectionView.showsVerticalScrollIndicator = true
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.backgroundColor = UIColor.white
        newsCollectionView.showsVerticalScrollIndicator = false
        mainView1.addSubview(self.newsCollectionView)
        newsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        newsCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        newsCollectionView.leftAnchor.constraint(equalTo: mainView1.leftAnchor).isActive = true
        newsCollectionView.rightAnchor.constraint(equalTo: mainView1.rightAnchor).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: mainView1.bottomAnchor).isActive = true
    }
    //MARK:- Create TableView
    func createTableView()
       {
        mainTableView = UITableView(frame: view.frame, style: UITableView.Style.grouped)
        mainTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        mainTableView.register(UINib(nibName: "PlaceHolderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceHolderTableViewCell")
           mainTableView.delegate = self
           mainTableView.dataSource = self
           //self.mainTableView.backgroundColor = UIColor.white
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.separatorColor = UIColor.clear
        mainView1.addSubview(self.mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        mainTableView.leftAnchor.constraint(equalTo: mainView1.leftAnchor).isActive = true
        mainTableView.rightAnchor.constraint(equalTo: mainView1.rightAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: mainView1.bottomAnchor).isActive = true
        
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(authorArray.count == 0)
        {
            return 10
        }else
        {
            return authorArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(authorArray.count == 0)
        {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "PlaceHolderTableViewCell", for: indexPath) as! PlaceHolderTableViewCell
            return cell
        }else
        {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.authorLbl.text = authorArray[indexPath.row] as? String
        cell.descriptionLbl.text = descriptionArray[indexPath.row] as? String
        
        if(imgURLArray[indexPath.row] is NSNull)
        {
            cell.contentImgView.image = UIImage(named: "NoImage")
        }else
        {
            do{
                cell.contentImgView.image = try UIImage(data: Data(contentsOf: URL(string: imgURLArray[indexPath.row] as! String)!))
            }catch
            {
                print("Error while loading image")
            }

        }
            return cell
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let TableViewNewsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TableViewNewsViewController") as? TableViewNewsViewController
        //var someString:String = contentArray[indexPath.row] as! String
        TableViewNewsViewController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(TableViewNewsViewController!, animated: true, completion: {
            TableViewNewsViewController?.newsLbl.text = "\((self.contentArray[indexPath.row]))   \n - Swipe left to see more"
            TableViewNewsViewController?.authorLbl.text = "Author : \(self.authorArray[indexPath.row])"
            TableViewNewsViewController?.url = "\(self.urlArray[indexPath.row])"
            if(self.imgURLArray[indexPath.row] is NSNull)
            {
                TableViewNewsViewController?.newsImgView.image = UIImage(named: "NoImage")
            }else
            {
                do{
                    TableViewNewsViewController?.newsImgView.image = try UIImage(data: Data(contentsOf: URL(string: self.imgURLArray[indexPath.row] as! String)!))
                }catch
                {
                    print("Error while loading image")
                }

            }
        })
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }



    //MARK:- Button Action
    @IBAction func onTapOfButton(_ sender: UIBarButtonItem) {
        if(isSideViewShowing)
        {
            if(sideViewWidthAnchor.constant == 260)
            {
                sideViewLeadingAnchor.constant = -260
                mainView1TrailingAnchor.constant = 0
                print(sideViewLeadingAnchor.constant)
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            }else if(sideViewWidthAnchor.constant == 350)
            {
                sideViewLeadingAnchor.constant = -350
                mainView1TrailingAnchor.constant = 0
                print(sideViewLeadingAnchor.constant)
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            }else{
                sideViewLeadingAnchor.constant = -450
                mainView1TrailingAnchor.constant = 0
                print(sideViewLeadingAnchor.constant)
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
        else
        {
            sideViewLeadingAnchor.constant = 0
            mainView1TrailingAnchor.constant = -260
            mainView1LeadingAnchor.constant = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSideViewShowing = !isSideViewShowing
    
    }
    
}
//MARK:- CollectionView Delegates
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(authorArray.count == 0)
        {
            return 10
        }else
        {
            return authorArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(authorArray.count == 0)
        {
            let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "PlaceHolderCollectionViewCell", for: indexPath) as! PlaceHolderCollectionViewCell
            return cell
        }else
        {
            let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            //cell.newsLbl.text = authorArray[indexPath.row] as? String
            cell.newsContentLbl.text = descriptionArray[indexPath.row] as? String
            
            if(imgURLArray[indexPath.row] is NSNull)
            {
                cell.newsImgView.image = UIImage(named: "NoImage")
            }else
            {
                do{
                    cell.newsImgView.image = try UIImage(data: Data(contentsOf: URL(string: imgURLArray[indexPath.row] as! String)!))
                }catch
                {
                    print("Error while loading image")
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NVC") as? NewsViewController
        newsViewController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(newsViewController!, animated: true, completion: {
            newsViewController?.news = "\((self.contentArray[indexPath.row]))   \n - Swipe left to see more"
            newsViewController?.author = "Author : \(self.authorArray[indexPath.row])"
            newsViewController?.url = "\(self.urlArray[indexPath.row])"
            if(self.imgURLArray[indexPath.row] is NSNull)
            {
                newsViewController?.imgUrl = "NoImage"
            }else
            {
                newsViewController?.imgUrl = self.imgURLArray[indexPath.row] as! String
            }
        })
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
//MARK:- UINavigationController Extension for completion Block
extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
