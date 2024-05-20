import UIKit
import PureLayout
import MovieAppData

class MovieListViewController: UIViewController, MovieNavigationDelegate, UICollectionViewDelegate  {
    
    private var collectionView: UICollectionView!
    private let movieUseCase: MovieUseCaseProtocol = MovieUseCase()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieList()
       
    }
    
    
    func navigateToMovieDetails(with movieID: Int) {
           let movieDetailsViewController = MovieDetailsViewController(movieID: movieID)
           navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    private func setupMovieList() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieListSectionCell.self, forCellWithReuseIdentifier: "MovieListSectionCell")
        collectionView.register(MovieListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MovieListHeaderView")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    
}
    
    
extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 // Three sections: What's Popular, Free to Watch, Trending
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // Each section contains a single horizontally scrolling collection view
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListSectionCell", for: indexPath) as! MovieListSectionCell
        cell.configure(with: indexPath.section, movieUseCase: movieUseCase, delegate: self)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieListHeaderView", for: indexPath) as! MovieListHeaderView
        headerView.backgroundColor = .clear
        
        switch indexPath.section {
        case 0:
            headerView.titleLabel.text = "What's popular"
        case 1:
            headerView.titleLabel.text = "Free to Watch"
        case 2:
            headerView.titleLabel.text = "Trending"
        default:
            break
        }
        return headerView
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

