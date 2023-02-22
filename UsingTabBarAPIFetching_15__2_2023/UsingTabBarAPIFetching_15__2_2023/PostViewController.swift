//
//  PostViewController.swift
//  UsingTabBarAPIFetching_15__2_2023
//
//  Created by Mac on 15/02/23.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
tableViewDelegateAndDataSource()
        registerXib()
        fetchingAPI()
    }
    func tableViewDelegateAndDataSource(){
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    func registerXib(){
        let uiNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.postTableView.register(uiNib, forCellReuseIdentifier: "PostTableViewCell")
    }
    func fetchingAPI(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        var session = URLSession(configuration: .default)
        var dataTask = session.dataTask(with: request){
            data , response , error in
            
            print("Data -- \(data)")
            print("Response -- \(response)")
            print("Error--\(error)")
            var getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            
            for dictionary in getJSONObject{
                let eachDictionary = dictionary as [String : Any]
                let postId = eachDictionary["id"] as! Int
                let postTitle = eachDictionary["title"] as! String
                let postBody = eachDictionary["body"] as! String
                
                let newPostObject = Post(id:postId, title: postTitle, body: postBody)
                
                self.posts.append(newPostObject)
            }
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }
        dataTask.resume()
}
}
extension PostViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 200
    }
}
extension PostViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        cell.idlbl.text = String(self.posts[indexPath.row].id)
        cell.titlelbl.text = self.posts[indexPath.row].title
        cell.bodylbl.text = self.posts[indexPath.row].body
        
        return cell
    }

}

