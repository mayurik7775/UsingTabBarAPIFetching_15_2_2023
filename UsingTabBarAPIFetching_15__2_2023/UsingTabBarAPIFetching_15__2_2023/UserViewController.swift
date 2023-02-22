//
//  UserViewController.swift
//  UsingTabBarAPIFetching_15__2_2023
//
//  Created by Mac on 15/02/23.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var users : [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
tableViewDelegateAndDataSource()
        registerXib()
    fetchingAPI()
    }
    func tableViewDelegateAndDataSource(){
        userTableView.delegate = self
        userTableView.dataSource = self
    }
    func registerXib(){
        let uiNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.userTableView.register(uiNib, forCellReuseIdentifier: "UserTableViewCell")
    }
    func fetchingAPI(){
        let urlString = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){
            data , response , error in
            print("Data --\(data)")
            print("Response --\(response)")
            print("Error--\(error)")
            
            let getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for dictionary in getJSONObject{
                let eachDictionary = dictionary as! [String : Any]
                let userId = eachDictionary["id"] as! Int
                let userName = eachDictionary["name"] as! String
                let Username = eachDictionary["username"] as! String
                let userEmail = eachDictionary["email"] as! String
                
                var newUser = User(id: userId, name: userName, username: Username, email: userEmail)
                self.users.append(newUser)
            }
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}
extension UserViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
extension UserViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        cell.idlbl.text = String(self.users[indexPath.row].id)
        cell.namelbl.text = self.users[indexPath.row].name
        cell.usernamelbl.text = self.users[indexPath.row].username
        cell.emaillbl.text = self.users[indexPath.row].email
        
        return cell
        
    }
}
