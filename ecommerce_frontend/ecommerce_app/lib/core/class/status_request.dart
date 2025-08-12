enum StatusRequest {
  loading, // When a request is in progress
  success, // When data is fetched successfully
  failure, // Generic request failure
  serverFailure, // Server returned an error (500, 404, etc.)
  offlineFailure, // No internet connection
}
