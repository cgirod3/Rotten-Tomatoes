## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 5.5 hours
Was hoping to spend more and complete the optional requirements, but the first few weeks of this quarter are pretty busy.
In the future, I will definitely work on implementing them.

### Features

#### Required

- User can view a list of movies. Poster images load asynchronously.
- User can view movie details by tapping on a cell.
- User sees loading state while waiting for the API.
- User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- User can pull to refresh the movie list.

#### Optional

- [ ] All images fade in.
- [ ] For the larger poster, load the low-res first and switch to high-res when complete.
- [ ] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `NSURLRequestReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [ ] Customize the highlight and selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Add a tab bar for Box Office and DVD.
- [ ] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough

![alt tag](https://github.com/cgirod3/Rotten-Tomatoes/blob/master/Rotten%20Tomatoes/RottenTomatoes%20walkthrough.gif)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
