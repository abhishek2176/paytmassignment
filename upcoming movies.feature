Feature: GET:: Fetch all upcoming movies

  Background:
    * url 'https://apiproxy.paytm.com/v2'
    * def pattern = 'yyyy-mm-dd'
    * def getDate =
    """
      function() {
        var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
        var sdf = new SimpleDateFormat(pattern);
        var date = new java.util.Date();
        var formattedDate = sdf.format(date);
        return sdf.parse(formattedDate).time;
      }
    """
    * def today = getDate()

    * def convertStringToDate =
    """
      function(stringDate) {
      var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
      var sdf = new SimpleDateFormat(pattern)
      return sdf.parse(stringDate).time;
    }
    """

    * def isValidMovieReleaseDate = function(releaseDate) { return convertStringToDate(releaseDate) > today }
    * def isValidPosterUrl = function(url) { return new RegExp('(.*)\.jpg').test(url)  }
    * def getDistinctMovieCodes =
    """
    function(paytmMovieCodes) {
      var distinct = new java.util.HashSet(paytmMovieCodes);
      return distinct.size();
    }
    """

  Scenario: Fetching a existent notification
    Given path '/movies/upcoming'
    When method GET
    Then status 200
    * def paytmMovieCodes = get response $.upcomingMovieData[*].paytmMovieCode
    * def distinctCount = getDistinctMovieCodes(paytmMovieCodes)
    And match paytmMovieCodes == '#[distinctCount]'
    And match each response.upcomingMovieData contains
    """
    {
      provider_moviename: '#string',
      moviePosterUrl: '#? isValidPosterUrl(_)',
      movieTitle: '#string',
      movie_name: '#string',
      language: '#string',
      genre: '#[_ > 0]',
      releaseDate: '#? isValidMovieReleaseDate(_)',
      rank: '#number',
      paytmMovieCode: '#string',
      isContentAvailable: '#number'
    }
    """


    #language: '#string' will make sure that language has only 1 language format and is a string
