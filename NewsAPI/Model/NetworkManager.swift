//
//  NetworkManager.swift
//  KwikMartProject
//
//  Created by Ram on 05/04/21.
//

import Foundation
import UIKit
class NetworkManager: NSObject {
    static var shared = NetworkManager()
    
    var newsArray:NSArray?
    var newsDataDictionary:NSDictionary?
    var authorArray:Array = [Any]()
    var titleArray:Array = [Any]()
    var descriptionArray:Array = [Any]()
    var imgURLArray:Array = [Any]()
    var contentArray:Array = [Any]()
    var covidData:[String:Any] = ["":""]
    
    var countryData:[String:Any]?
    private override init() {
        super.init()
        //APICall { (Data, err) in
            //print(Data!)
        //}
//        covidAPI { (Data, err) in
//            print(Data!)
//        }
        covidAPI()
    }
    
    func APICall(completion:@escaping(NSArray?,Error?) -> Void){
        let urlString = "\(Constants.news_API)&apiKey=\(Constants.news_API_Key)"

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { [self] (data, response, error) in
          if error != nil {
            print(error!)
            completion(nil,error)
          } else {
            do {

                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
              //let currentConditions = parsedData
                //print(currentConditions[0])
                
                let someDict:[String:Any] = parsedData
                self.newsArray = someDict["articles"]! as? NSArray
                completion(newsArray,nil)
                //print(self.newsArray!.count)
                //print(self.newsArray!)
                
                for i in 0..<self.newsArray!.count
                {
                    self.newsDataDictionary = ((self.newsArray![i]) as! NSDictionary)
                    //print(self.newsDataDictionary!["author"]!)
                    
                        self.authorArray.append(self.newsDataDictionary!["author"]!)
                    
                    
                    self.titleArray.append(self.newsDataDictionary!["title"]!)
                    self.descriptionArray.append(self.newsDataDictionary!["description"]!)
                    self.imgURLArray.append(self.newsDataDictionary!["urlToImage"]!)
                    self.contentArray.append(self.newsDataDictionary!["content"]!)
                }
                //print(contentArray)
                
            } catch let error as NSError {
              print(error)
            }
          }

        }.resume()
        
    }
    
    func covidAPI(){
        let urlString = Constants.covid_API

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { [self] (data, response, error) in
          if error != nil {
            print(error!)
            //completion(nil,error)
          } else {
            do {

                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                covidData = parsedData
                self.countryData = covidData["countryInfo"]! as? [String:Any]
                
                
               // completion(someDict,nil)
            } catch let error as NSError {
              print(error)
            }
          }

        }.resume()
        
    }
}
