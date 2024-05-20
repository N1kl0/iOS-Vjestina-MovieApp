//
//  movieData.swift
//  movieApp
//
//  Created by <3 on 02.04.2024..
//

import Foundation
import MovieAppData

class MovieData{
        
    var id: Int?
    var name: String?
    var summary: String?
    var imageUrl: String?
    var releaseDate: String?
    var year: Int?
    var duration: Int?
    var rating: Double?
    var categories: [MovieCategoryModel]?
    var crewMembers: [MovieCrewMemberModel]?
    var allMovies: [MovieModel]?
    var popularMovies: [MovieModel]?
    var freeToWatchMovies: [MovieModel]?
    var trendingMovies: [MovieModel]?
    
    
    
    init(movieID : Int){
        
        if let movieDetails = MovieUseCase().getDetails(id: movieID){
            
            id = movieDetails.id
            name = movieDetails.name
            summary =  movieDetails.summary
            imageUrl = movieDetails.imageUrl
            releaseDate = movieDetails.releaseDate
            year = movieDetails.year
            duration = movieDetails.duration
            rating = movieDetails.rating
            categories = movieDetails.categories
            crewMembers = movieDetails.crewMembers
            allMovies = MovieUseCase().allMovies
            popularMovies = MovieUseCase().popularMovies
            freeToWatchMovies = MovieUseCase().freeToWatchMovies
            trendingMovies = MovieUseCase().trendingMovies
            
        }
    }
    
    func getMoviesFromSeries() -> [(movie: MovieModel, year: Int)] { 
            guard let seriesName = name?.components(separatedBy: " ").first else { return [] }
            return allMovies?.compactMap { movie in
                if movie.name.starts(with: seriesName) {
                    let movieData = MovieData(movieID: movie.id)
                    if let year = movieData.year {
                        return (movie, year)
                    }
                }
                return nil
            } ?? []
        }
    
    
}
