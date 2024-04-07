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
        }
    }
    
    
}
