//
//  MovieDetailView.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class MovieDetailView:BaseView {
    
    public var movie:Movie! {
        didSet {
            config(movie: movie)
        }
    }
    
    lazy var tableView:UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.registerCell(ofType: MovieDetailCell.self)
        tv.registerCell(ofType: MovieStatusCell.self)
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.separatorColor = .black
        tv.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        return tv
    }()
    
    lazy var headerImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "cover-placeholder")
        return iv
    }()
    
    lazy var footerView:UIButton = {
        let iv = UIButton()
        iv.backgroundColor = .appBlue
        iv.setTitle("Watch Now", for: .normal)
        iv.titleLabel?.font = .fixelText(size: 16, weight: .black)
        iv.setTitleColor(.white, for: .normal)
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        subviews(tableView)
        tableView.fillContainer()
        tableView.sectionHeaderTopPadding = 0
    }
    
    func config(movie:Movie) {
        if let backpath = movie.backdropPath, let url = movie.backdropURL {
            loadImageFromCacheOrAPI(posterPath: backpath, url: url,placeHolder: "cover-placeholder") { image in
                DispatchQueue.main.async {
                    self.headerImageView.image = image
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension MovieDetailView: UITableViewDelegate,
                           UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else {return UITableViewCell()}
        switch indexPath.row {
        case 0:
            let cell:MovieDetailCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            cell.config(movie: movie)
            return cell
        default:
            let cell:MovieStatusCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            cell.config(movie: movie)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerImageView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.bounds.width * 0.6
    }
}
