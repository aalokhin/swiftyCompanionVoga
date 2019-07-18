//
//  ViewController.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/9/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//



/*
 let json = try? JSONSerialization.jsonObject(with: d, options: [])
 print(json ?? "nothing was serialized")
 DispatchQueue.main.async {
 self.lblWithResults.text = searchText
 }
 
 */

// "\u{001B}[1;36m\n ============== \u{001B}[0m\n")

import UIKit

class ViewController: UIViewController {


    var code : String = ""
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getToken()
    }
    
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
   
    func getToken(){
        
            print( "we need a brand new token")
            let queryItems = [
            NSURLQueryItem(name: "grant_type", value: "client_credentials"),
            NSURLQueryItem(name: "client_id", value: Client.apiUid),
            NSURLQueryItem(name: "client_secret", value : Client.apiSecret),
            NSURLQueryItem(name: "scope", value: "public")
            ]
            let urlComps = NSURLComponents(string: "https://api.intra.42.fr/oauth/token")!
            urlComps.queryItems = queryItems as [URLQueryItem]
            let url = urlComps.url!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            DispatchQueue.global().async{
                let task = URLSession.shared.dataTask(with: request) {data, response, error in
                    if let err = error {
                        
                        print("error occured \(err)")
                    } else if let d = data
                    {
                        self.parseToken(d : d)
                    }
                }
                task.resume()
            }
    }
    
    
    func parseToken(d : Data!){
        let decoder = JSONDecoder()
        guard let t = try? decoder.decode(TokenJSON.self, from: d) else {
            print("error decoding token")
        
          callErrorWithCustomMessage("error decoding token")
            return
        }
        print("here is you token: ")
//        print(String(describing: t.access_token))
//        print(t.expires_in ?? "No token")
//        print(t.created_at  ?? "No token")
        guard let token = t.access_token else {
            callErrorWithCustomMessage("No token!")
            return
        }
            Client.sharedInstance.setToken(t: token)
        
    }
    

}

extension ViewController: UISearchBarDelegate {
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        print(searchBar.text ?? "nothing searched")
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print(Client.sharedInstance.token)

        let queryItems = [
            NSURLQueryItem(name: "access_token", value: Client.sharedInstance.token)
        ]
        let searchQuery =  searchText.lowercased().addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        print(searchQuery)
        
        let urlComps = NSURLComponents(string: "https://api.intra.42.fr/v2/users/\(searchQuery)")
        urlComps?.queryItems = queryItems as [URLQueryItem]
        let url = urlComps?.url!
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        getUser(request: request)
        
    }
    
    
    func getUser(request : URLRequest){
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let err = error {
                print("error occured \(err)")
                return
            } else if let _ = response, let d = data {
                // print(r)
                
                
                //*********************************** decode ******************
                
                let decoder = JSONDecoder()
                guard let user = try? decoder.decode(FinalUser.self, from: d) else {
                    print("error decoding user")
                    self.callErrorWithCustomMessage("Errror decoding user!")
                    return
                }
                if (user.displayname == nil)
                {
                    print("no such user")
                    self.callErrorWithCustomMessage("No such user!")
                    return
                }
                print("here we go")
                
                
                Client.sharedInstance.setUser(u: user)
                
                let json = try? JSONSerialization.jsonObject(with: d, options: [])
                //print(json ?? "nothing was serialized")
                //user.printUser()
                // self.printUser()
                
                
                DispatchQueue.main.async {
                    self.evokeViewController(storyboard : "UserInfo", vcIdentifier : "UserInfoVC")
                }
                
                 
                 
            }
        }
        task.resume()
    }
 
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}


extension ViewController {
    
    func evokeViewController(storyboard : String, vcIdentifier : String){
        //let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier : vcIdentifier)
        performSegue(withIdentifier: "UserInfoSegue", sender: self)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callErrorWithCustomMessage(_ message : String) {
        
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

