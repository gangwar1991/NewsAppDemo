class ApiConstants {
  /**Server url*/

  ///For Developer
  static const PRODUCTION_BASE_URL =
      "https://qc0q23lp3d.execute-api.ap-south-1.amazonaws.com/dev/v1/";

  static const DEV_BASE_URL = "https://newsapi.org/v2/";

  static const POPULAR_NEWS =
      'everything?q=apple&from=2021-08-02&to=2021-08-02&sortBy=popularity&apiKey=30e36c24c72e4fe3ba02edd826dd143d';
  static const TESLA_NEWS =
      'everything?q=tesla&from=2021-07-03&sortBy=publishedAt&apiKey=30e36c24c72e4fe3ba02edd826dd143d';
}
