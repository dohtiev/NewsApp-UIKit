//
//  ArticleTableViewController.swift
//  NewsApp UIKit
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    enum Section{
        case all
    }
    
    var articles:[Article] = [
        Article(
            name: "Lifehacker.com",
            author: "Daniel Oropeza",
            title: "US law enforcement has warrantless access to many money transfers",
            description: "Your international money transfers might not be as discreet as you think. Senator Ron Wyden and The Wall Street Journal have learned that US law enforcement can access details of money transfers without a warrant through an obscure surveillance program the Ar…",
            url: "https://www.engadget.com/us-money-transfer-mass-surveillance-trac-183552282.html",
            urlToImage: "https://s.yimg.com/os/creatr-uploaded-images/2023-01/10302b40-9755-11ed-8bfd-2c415af0c89b",
            publishedAt: "2023-01-18T18:35:52Z"
        ),
        Article(
            name: "Lifehacker.com",
            author: "Daniel Oropeza",
            title: "US law enforcement has warrantless access to many money transfers",
            description: "Your international money transfers might not be as discreet as you think. Senator Ron Wyden and The Wall Street Journal have learned that US law enforcement can access details of money transfers without a warrant through an obscure surveillance program the Ar…",
            url: "https://www.engadget.com/us-money-transfer-mass-surveillance-trac-183552282.html",
            urlToImage: "https://s.yimg.com/os/creatr-uploaded-images/2023-01/10302b40-9755-11ed-8bfd-2c415af0c89b",
            publishedAt: "2023-01-18T18:35:52Z"
        )
    ]
    
    
//articles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
        tableView.separatorStyle = .none
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.all])
        snapshot.appendItems(articles, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    lazy var dataSource = configureDataSource()
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Article>{
        let cellIdentifier = "articlecell"

        let dataSource = UITableViewDiffableDataSource<Section, Article>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, article in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell
                
                
                let urlToImage = URL(string: String(article.urlToImage))!
                cell.thumbnailImageView.image = UIImage(named: "prototype.jpg")
                
                DispatchQueue.global().async {
                    // Fetch Image Data
                    print("In async...")
                    if let data = try? Data(contentsOf: urlToImage) {
                        DispatchQueue.main.async {
                            // Create Image and Update Image View
                            print("Download...")
                            cell.thumbnailImageView.image = UIImage(data: data)
                            print("Succeed")
                        }
                    }
                }
                
                cell.nameLabel.text = article.name
                cell.authorLabel.text = article.author
                cell.titleLabel.text = article.title
                cell.titleLabel.numberOfLines = 2
                cell.descriptionLabel.text = article.description
                //                cell.descriptionLabel.lineBreakMode = .byCharWrapping
                cell.descriptionLabel.numberOfLines = 3
                cell.publishedAtLabel.text = formatDate(date: article.publishedAt)
                return cell
            }
        )
        return dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleDetail" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! ArticleDetailViewController
                destinationController.urlFromMainView = self.articles[indexPath.row].url
            }
        }
    }
    
}
