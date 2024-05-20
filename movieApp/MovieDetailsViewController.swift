//
//  MovieDetailsViewController.swift
//  movieApp
//
//  Created by <3 on 02.04.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieDetailsViewController: UIViewController{
    
    var Image: UIImageView!//part with picture
    var data: UIView!//white part with data
    //var info: UIView!// should be borders of info
    
    var stackView: UIStackView!
    var rating: UILabel!
    var name: UILabel!
    var year: UILabel!
    var releaseDate: UILabel!
    var duration: UILabel!
    var categories: UILabel!
    var crewMembers: UILabel!
    var summary: UILabel!
    
    private var textRectangle: UIView!
    private var descriptionRectangle: UIView!
    
    
    var movie: MovieData
    
    
    init(movieID: Int) {
           self.movie = MovieData(movieID: movieID)
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createImageView()
        CreateDataView()
        
        let data = MovieUseCase().allMovies
        print(data)
        
    }
    
    

    private func createImageView(){
        
        Image = UIImageView()
        
        let bounds = UIScreen.main.bounds
        let height = bounds.height * 0.45
        
        Image.autoSetDimensions(to: CGSize(width: bounds.width, height: height))
        
        if let imageUrl = movie.imageUrl{
            let url = URL(string: imageUrl)!
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        
                        
                        self.Image.image = UIImage(data: data)
                            
                        }
                    }
            }
            
            view.addSubview(Image)
            
            Image.contentMode = .scaleAspectFill
            Image.clipsToBounds = true
            Image.autoPinEdge(toSuperviewEdge: .leading)//leading je ljeva
            Image.autoPinEdge(toSuperviewEdge: .top)
            
        }
    
        AddLabelsImg()
    }

  
    private func CreateDataView(){
        
        data = UIView()
        
        data.backgroundColor = .white
        
        let bounds = UIScreen.main.bounds
        let height = bounds.height * 0.55
        
        data.autoSetDimensions(to: CGSize(width: bounds.width, height: height))
        
        data.contentMode = .scaleAspectFill
        data.clipsToBounds = true
        
        view.addSubview(data)
        
        data.autoPinEdge(toSuperviewEdge: .leading)//leading je ljeva
        data.autoPinEdge(toSuperviewEdge: .bottom)
        
        AddLabelsData()
        
    }
    
    
    private func AddLabelsImg(){
    
        let bounds = UIScreen.main.bounds
        let height = bounds.height * 0.25
        let sidePadding = 10
        let topPadding = 200
        
        textRectangle = UIView()
        rating = UILabel()
        name = UILabel()
        year = UILabel()
        releaseDate =  UILabel()
        duration = UILabel()
        categories = UILabel()
        
       
        
        textRectangle.backgroundColor = .clear
        textRectangle.frame = CGRect(x: 0, y: topPadding, width: Int(bounds.width), height: Int(height))
        
        if let ratingData = movie.rating, let nameData = movie.name, let yearData = movie.year, let releaseDateData = movie.releaseDate, let durationData = movie.duration, 
            let categoriesData = movie.categories {
            
            rating.text = String(ratingData)
            name.text = nameData
            year.text = "(\(yearData))"
            
            
            let a1 = releaseDateData.split(separator: "-")
            releaseDate.text = "\(a1[2])/\(a1[1])/\(a1[0]) (US)"
            
            
            let h = Int(durationData / 60)
            let min = durationData % 60
            duration.text = "\(String(h))h\(String(min))min"
            
            
            var a2 = ""
            for i in 0 ..< categoriesData.count{
                a2 = a2 + (String(describing: categoriesData[i]).capitalized)
                if i < categoriesData.count - 1{
                    a2 = a2 + ","
                }
            }
            categories.text = a2
        }
        
        
        let UserScore = UILabel()
        UserScore.text = "User score"
        let Icon = UIButton(type: .custom)
        
    
        rating.textColor = .white
        UserScore.textColor = .white
        name.textColor = .white
        year.textColor = .white
        releaseDate.textColor = .white
        duration.textColor = .white
        categories.textColor = .white
        Icon.setImage(UIImage(systemName: "star"), for: .normal)
        Icon.tintColor = .white
        Icon.backgroundColor = .darkGray
        Icon.layer.cornerRadius = 15
        
        
        rating.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        UserScore.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        name.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        year.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        
        releaseDate.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        
        categories.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        duration.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        Icon.autoSetDimensions(to: CGSize(width: 30, height: 30))
    
        textRectangle.addSubview(rating)
        textRectangle.addSubview(UserScore)
        textRectangle.addSubview(name)
        textRectangle.addSubview(year)
        textRectangle.addSubview(releaseDate)
        textRectangle.addSubview(duration)
        textRectangle.addSubview(categories)
        textRectangle.addSubview(Icon)
        
        
        //rating.frame = CGRect(x: 20, y: 70, width: bounds.width, height: height)
        rating.autoPinEdge(.top, to: .top, of: textRectangle)
        rating.autoPinEdge(.leading, to: .leading, of: textRectangle, withOffset: 10)
        UserScore.autoPinEdge(.top, to: .top, of: textRectangle)
        UserScore.autoPinEdge(.leading, to: .trailing, of: rating, withOffset: 10)
        
        name.autoPinEdge(.top, to: .bottom, of: rating, withOffset: 25)
        name.autoPinEdge(.leading, to: .leading, of: textRectangle, withOffset: 10)
        year.autoPinEdge(.top, to: .bottom, of: UserScore, withOffset: 25)
        year.autoPinEdge(.leading, to: .trailing, of: name, withOffset: 5)
        
        releaseDate.autoPinEdge(.top, to: .bottom, of: name, withOffset: 25)
        releaseDate.autoPinEdge(.leading, to: .leading, of: textRectangle, withOffset: 10)
        
        categories.autoPinEdge(.top, to: .bottom, of: releaseDate)
        categories.autoPinEdge(.leading, to: .leading, of: textRectangle, withOffset: 10)
        duration.autoPinEdge(.top, to: .bottom, of: releaseDate)
        duration.autoPinEdge(.leading, to: .trailing, of: categories, withOffset: 5)
        
        Icon.autoPinEdge(.leading, to: .leading, of: textRectangle, withOffset: 20)
        Icon.autoPinEdge(.top, to: .bottom, of: categories, withOffset: 2)
        
        Image.addSubview(textRectangle)
        
    }
    
    
    private func AddLabelsData(){
        
        let Overwiev = UILabel()

        let bounds = UIScreen.main.bounds
        let heightU = bounds.height * 0.15
        let heightL = bounds.height * 0.40
        let topPadding = 0
        
        descriptionRectangle = UIView()
        crewMembers = UILabel()
        summary = UILabel()
        
        
        descriptionRectangle.backgroundColor = .white
        descriptionRectangle.frame = CGRect(x: 0, y: topPadding, width: Int(bounds.width), height: Int(heightU))
        
        
        Overwiev.text = "Overwiev"
        
        Overwiev.textColor = .black
        summary.textColor = .black
        
        Overwiev.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        summary.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.numberOfLines = 0
        
        
        descriptionRectangle.addSubview(Overwiev)
        descriptionRectangle.addSubview(summary)
        
        Overwiev.autoPinEdge(.top, to: .top, of: descriptionRectangle, withOffset: 10)
        Overwiev.autoPinEdge(.leading, to: .leading, of: descriptionRectangle, withOffset: 20)
        
        summary.autoPinEdge(.top, to: .bottom, of: Overwiev, withOffset: 10)
        summary.autoPinEdge(.leading, to: .leading, of: descriptionRectangle, withOffset: 10)
        summary.autoPinEdge(.trailing, to: .trailing, of: descriptionRectangle)
        
        if let summaryData = movie.summary {
            summary.text = summaryData
            
        }
        
        //sets the overwies/summary part^
//===============================================================================================
        
        
         let OGstack = UIStackView()
        
        data.addSubview(OGstack)
        
        OGstack.axis = .vertical
        OGstack.alignment = .fill
        OGstack.distribution = .fillEqually
        OGstack.spacing = 30
        
        
        OGstack.autoPinEdge(.top, to: .top, of: data, withOffset: 160)
        
        OGstack.autoPinEdge(.leading, to: .leading, of: data, withOffset: 15)
        OGstack.autoPinEdge(.trailing, to: .trailing, of: data, withOffset: -15)

        
        
        
        if let crewMembersData = movie.crewMembers{
            
            var rows = 0
            
            if crewMembersData.count % 3 == 0 {
                rows = crewMembersData.count / 3
            }else{
                rows = (crewMembersData.count / 3) + 1
            }
            
            var arrNames = [String](repeating: "", count: crewMembersData.count)
            var arrRoles = [String](repeating: "", count: crewMembersData.count)

            
            
            
            
            for i in 0 ..< crewMembersData.count - 1{
                arrNames[i] = String(describing: crewMembersData[i].name)
                arrRoles[i] = String(describing: crewMembersData[i].role)
            }
            
            
            for row in 0...rows - 1 {
                
                let namesAndRoles = UIStackView()
                
                namesAndRoles.axis = .horizontal
                namesAndRoles.alignment = .center
                namesAndRoles.distribution = .fillEqually
                
                OGstack.addArrangedSubview(namesAndRoles)
                
                let box1 = UIView()
                let box2 = UIView()
                let box3 = UIView()
                
                let boxes = [box1, box2, box3]
                
                for col in 0...2 {
                    boxes[col].autoSetDimension(.height, toSize: 50)
                    namesAndRoles.addArrangedSubview(boxes[col])
                    
                    for n in 0...arrNames.count - 1 {
                        if n == col + 3 * row {
                            
                            let crewName = UILabel()
                            let crewRole = UILabel()
                            
                            crewName.text = arrNames[n]
                            crewRole.text = arrRoles[n]
                            
                            crewName.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                            crewRole.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                            
                            boxes[col].addSubview(crewName)
                            boxes[col].addSubview(crewRole)
                            
                            crewName.autoPinEdge(.top, to: .top, of: boxes[col], withOffset: 5)
                            crewName.autoPinEdge(.left, to: .left, of:  boxes[col])
                            
                            crewRole.autoPinEdge(.top, to: .top, of: boxes[col], withOffset: 30 )
                            crewRole.autoPinEdge(.left, to: .left, of:  boxes[col])
                            
                            
                        }
                    }
                }
            }
        }
        data.addSubview(descriptionRectangle)
    }
}//zagrada od klase

