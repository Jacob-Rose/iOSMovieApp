//
//  MovieTableViewController.swift
//  iOSMovieApp
//
//  Created by user167502 on 3/18/20.
//  Copyright © 2020 jakerose. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell
{
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
}

class FavoriteMovieTableViewController: MovieTableViewController
{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movies = TMDBAPI.shared.getFavoriteMovies()
        tableView.reloadData()
    }
}

class PopularMovieTableViewController: MovieTableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBAPI.shared.loadPopularLocal()
        movies = TMDBAPI.shared.loadedMovies
    }
}

class MovieTableViewController: UITableViewController {

    var movies: Array<Movie> = Array<Movie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80

        //TMDBAPI.shared.loadPopularLocal()
        //movies = TMDBAPI.shared.loadedMovies
        //movies.append(contentsOf: TMDBAPI.shared.getPopular2())
    }

    // MARK: - Table view data source
    
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    //https://stackoverflow.com/questions/28430663/send-data-from-tableview-to-detailview-swift

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

        if segue.identifier == "movieDetail" {
            // initialize new view controller and cast it as your view controller

            let indexPath = tableView.indexPathForSelectedRow!
            if let viewController = segue.destination as? MovieDetailViewController
            {
                viewController.setMovie(newMovie: movies[indexPath.row])
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        if let image: UIImage = TMDBAPI.shared.loadMovieImage(url: movies[indexPath.row].posterPath)
        {
            cell.movieImage.image = image
            cell.movieTitle.text = movies[indexPath.row].title
        }

        return cell
    }
}