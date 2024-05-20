import UIKit
import MovieAppData
import PureLayout

class CategorizedMovieListViewController: UIViewController {
    private var tableView: UITableView!
    private let movieUseCase: MovieUseCaseProtocol = MovieUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print("View Did Load: TableView setup complete") // Debug print
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        print("Setup TableView: TableView registered and constraints set") // Debug print
    }
}

extension CategorizedMovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        switch indexPath.section {
        case 0:
            cell.configure(with: movieUseCase.popularMovies)
            print("Section 0: Popular Movies count \(movieUseCase.popularMovies.count)") // Debug print
        case 1:
            cell.configure(with: movieUseCase.freeToWatchMovies)
            print("Section 1: Free to Watch Movies count \(movieUseCase.freeToWatchMovies.count)") // Debug print
        case 2:
            cell.configure(with: movieUseCase.trendingMovies)
            print("Section 2: Trending Movies count \(movieUseCase.trendingMovies.count)") // Debug print
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "What's Popular"
        case 1:
            return "Free to Watch"
        case 2:
            return "Trending"
        default:
            return nil
        }
    }
}

extension CategorizedMovieListViewController: UITableViewDelegate {
    // Handle cell selection if needed
}

class CategoryCell: UITableViewCell {
    private var collectionView: UICollectionView!
    private var movies: [MovieModel] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        print("CategoryCell Initialized") // Debug print
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        print("Setup CollectionView: CollectionView registered and constraints set") // Debug print
    }

    func configure(with movies: [MovieModel]) {
        self.movies = movies
        collectionView.reloadData()
        print("Configure CategoryCell: Movies count \(movies.count)") // Debug print
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in section: \(movies.count)") // Debug print
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        print("Configuring cell at index \(indexPath.item) with movie \(movie.name)") // Debug print
        return cell
    }
}

class MovieCollectionCell: UICollectionViewCell {
    // Configure your cell with shadows and other UI elements
    func configure(with movie: MovieModel) {
        // Configure the cell with movie details
        print("MovieCollectionCell configured with movie: \(movie.name)") // Debug print
    }
}
