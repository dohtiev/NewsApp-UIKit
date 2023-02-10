//
//  ArticleTableViewController.swift
//  NewsApp UIKit
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    enum Section{
        case all
    }
    
    var articles: [Article] = []
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        fetchArticles()
        
        //        waiting for api response, usually takes 1-2 seconds (obviously there is a better way to solve this (will be fixed later :) ))
        while articles.count<1{
            sleep(1)
        }
        
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.all])
        snapshot.appendItems(articles, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: Constants.API_URL!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            self.articles = [Article]()
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]]{
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if
                            //                            let name = articleFromJson["name"] as? String,
                            let title = articleFromJson["title"] as? String,
                            let author = articleFromJson["author"] as? String,
                            let desc = articleFromJson["description"] as? String,
                            let url = articleFromJson["url"] as? String,
                            let urlToImage = articleFromJson["urlToImage"] as? String,
                            let publishedAt = articleFromJson["publishedAt"] as? String,
                            let content = articleFromJson["content"] as? String
                        {
                            //                            article.name = name
                            //                            print(name)
                            article.title = title
                            article.author = author
                            article.desc = desc
                            article.url = url
                            article.urlToImage = urlToImage
                            article.publishedAt = publishedAt
                            article.content = content
                            
                        }
                        self.articles.append(article)
                    }
                }
                
            } catch let error{
                print(error)
            }
        }
        task.resume()
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Article>{
        let cellIdentifier = "articlecell"
        let dataSource = UITableViewDiffableDataSource<Section, Article>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, articles in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell
                
//                TODO: Save each image to cache
                if articles.urlToImage != nil {
                    let urlToImage = URL(string: String(articles.urlToImage!))!
                    
                    cell.thumbnailImageView.image = UIImage(named: "prototype.jpg")
                    
                    //                Download image for each article from URL
                    DispatchQueue.global().async {
                        // Fetch Image Data
                        if let data = try? Data(contentsOf: urlToImage) {
                            DispatchQueue.main.async {
                                cell.thumbnailImageView.image = UIImage(data: data)
                            }
                        }
                    }
                } else {
                    cell.thumbnailImageView.image = UIImage(named: "prototype.jpg")
                }
                
                //                cell.nameLabel.text = articles.name
                cell.authorLabel.text = articles.author
                cell.titleLabel.text = articles.title
                cell.titleLabel.numberOfLines = 2
                cell.descriptionLabel.text = articles.desc
                //                cell.descriptionLabel.lineBreakMode = .byCharWrapping
                cell.descriptionLabel.numberOfLines = 3
                
                if articles.publishedAt == nil{
                    cell.publishedAtLabel.text = ""
                } else {
                    cell.publishedAtLabel.text = formatDate(date: articles.publishedAt!)
                }
                
                return cell
            }
        )
        return dataSource
    }
    
    //    Pass url data of the selected article to ArticleDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleDetail" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! ArticleDetailViewController
                destinationController.urlFromMainView = self.articles[indexPath.row].url!
            }
        }
    }
    
}
