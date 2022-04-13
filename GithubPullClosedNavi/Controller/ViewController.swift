//
//  ViewController.swift
//  GithubPullClosedNavi
//
//  Created by Naman Singh on 11/04/22.
//


// To operate this App -
// 1. Enter github user name in field 1
// 2. Enter github repo name in field 2
// 3. On clicking search button an api will be called and the required responses like project url,
//    avatar url, created date and state will be called.
// 4. This project has been created in the span of less than 1 hour. Maximum clean approach tried.
// 5. Hope you like this project.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var repoField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var responseTableView: UITableView!
    
    var gitServerResponse = [GitResponse]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseTableView.dataSource = self
        responseTableView.delegate = self
        userNameField.delegate = self
        repoField.delegate = self
        registerNibCells()
        searchButton.layer.cornerRadius = 5.0
        responseTableView.reloadData()
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        print(userNameField.text ?? " ")
        if userNameField.text == "" {
            print("Plz enter response")
            alertViewWhenNeeded(alertTitle: "Note", alertMessage: "Plz Enter Response")
        } else if repoField.text == "" {
            alertViewWhenNeeded(alertTitle: "Note", alertMessage: "Plz Enter Response")
        }
        callAPI(userName: userNameField.text!, projectName:
                    repoField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(userNameField.text ?? " ")
        return true
    }
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {
          
        if let gitUserName = userNameField.text, let gitRepoName = repoField.text {
              callAPI(userName: gitUserName, projectName: gitRepoName)
          }
          
      }
    
    func callAPI(userName: String, projectName: String){
        guard let url = URL(string: "https://api.github.com/repos/\(userName)/\(projectName)/pulls") else{
            return
        }


        let task = URLSession.shared.dataTask(with: url){
           [weak self] data, response, error in
            
            let decoder = JSONDecoder()

                    if let data = data {
                        do {
                            let tasks = try decoder.decode([GitResponse].self, from: data)
                            tasks.forEach { i in
                                
                                if self?.gitServerResponse != nil {
                                    print(i.id)
                                    print(i.node_id)
                                    print(i.number)
                                    print(i.state)
                                    
                                    DispatchQueue.main.async {
                                        self?.gitServerResponse = tasks
                                        self?.responseTableView.reloadData()
                                    }
                                } else {
                                    print("Empty Response")
                                }
                              
                            }
                        } catch {
                            print(error)
                            print("No Response")
                        }
                    }
                }

        task.resume()
    }
    
    func registerNibCells() {
        responseTableView.register(UINib(nibName: "HeadSegTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadSegTableViewCell")
        responseTableView.register(UINib(nibName: "SecondSegTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondSegTableViewCell")
        responseTableView.register(UINib(nibName: "LastSegTableViewCell", bundle: nil), forCellReuseIdentifier: "LastSegTableViewCell")
    }
    
    func alertViewWhenNeeded(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gitServerResponse.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let topCell = responseTableView.dequeueReusableCell(withIdentifier: "HeadSegTableViewCell", for: indexPath) as! HeadSegTableViewCell
            topCell.userNameLabel.text = userNameField.text
        return topCell
        } else if indexPath.row == 1 {
            
            let midCell = responseTableView.dequeueReusableCell(withIdentifier: "SecondSegTableViewCell", for: indexPath) as! SecondSegTableViewCell
            midCell.projectNameLabel.text = repoField.text
            return midCell
        } else {
            let index = indexPath.row - 2
            let endCell = responseTableView.dequeueReusableCell(withIdentifier: "LastSegTableViewCell", for: indexPath) as! LastSegTableViewCell
            endCell.stateLabel.text = gitServerResponse[index].state
            endCell.createDateLabel.text = gitServerResponse[index].created_at
            endCell.closeDateLabel.text = gitServerResponse[index].closed_at
            endCell.profileImgView.downloaded(from: gitServerResponse[index].user?.avatar_url ?? "")
            return endCell
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

