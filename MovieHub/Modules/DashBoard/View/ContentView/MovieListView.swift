//
//  MovieListView.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

protocol MovieListViewDelegate:AnyObject {
    func fetchNextPageIfAvailable()
    func didTapMoive(movie:Movie)
}

class MovieListView:BaseView {
    
    weak var delegate:MovieListViewDelegate?
    
    private var movies:[Movie] = []
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.registerCell(ofType: MovieCell.self)
        cv.register(ActivityFooterView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: ActivityFooterView.identifier)
        cv.dataSource = self
        cv.delegate = self
        cv.contentInset = .init(top: 16, left: 16, bottom: 60, right: 16)
        cv.backgroundColor = .clear
        return cv
    }()
    
    private var footerView = ActivityFooterView()
    
    override func setupViews() {
        super.setupViews()
        subviews(collectionView)
        collectionView.fillContainer()
    }
    
    func appendMovies(movies:[Movie]) {
        let startIndex = self.movies.count
        self.movies.append(contentsOf: movies)
        self.footerView.stopAnimating()
        DispatchQueue.main.async {
            var indexPaths = [IndexPath]()
            for (index, _) in movies.enumerated() {
                let indexPath = IndexPath(item: startIndex + index, section: 0)
                indexPaths.append(indexPath)
            }
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: indexPaths)
            }, completion: nil)
        }
        
    }
    
}

extension MovieListView: UICollectionViewDataSource,
                         UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieCell = collectionView.dequeueTypedCell(forIndexPath: indexPath)
        cell.config(movie: movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        delegate?.didTapMoive(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == movies.count - 1 {
            footerView.startAnimating()
            delegate?.fetchNextPageIfAvailable()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ActivityFooterView.identifier, for: indexPath)
            self.footerView = footer as! ActivityFooterView
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
}
extension MovieListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 48) / 3
        return CGSize(width: width, height: width * 1.5)
    }
}

