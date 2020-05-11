class ApiResponse<T> {
  Status status;

  T data;

  String message;

  ApiResponse.loading(this.message) : status = Status.Loading;

  ApiResponse.completed(this.data) : status = Status.Completed;

  ApiResponse.error(this.message) : status = Status.Error;

  ApiResponse.unNotifiedError(this.message, this.data)
      : status = Status.UnNotifiedError;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { Loading, Completed, Error, UnNotifiedError }
