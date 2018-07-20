#' Upload a file to an S3 object
#'
#' @md
#' @param filename path to the file to download to.
#' @param bucket name of the bucket to download from.
#' @param key name of the key to download from.
#' @param extra_args arguments that may be passed to the client operation.
#' @param transfer_config transfer configuration to be used when performing the transfer.
#' Pre-defined, default values are provided for the following settings:
#' - `multipart_threshold`: The transfer size threshold for which multipart uploads,
#'   downloads, and copies will automatically be triggered.
#' - `max_concurrency`: The maximum number of threads that will be making requests
#'   to perform a transfer. If use_threads is set to False, the value provided is
#'   ignored as the transfer will only ever use the main thread.
#' - `multipart_chunksize`: The partition size of each part for a multipart transfer.
#' - `num_download_attempts`: The number of download attempts that will be retried
#'   upon errors with downloading an object in S3. Note that these retries account
#'   for errors that occur when streaming down the data from s3 (i.e. socket errors
#'   and read timeouts that occur after recieving an OK response from s3). Other
#'   retryable exceptions such as throttling errors and 5xx errors are already
#'   retried by botocore (this default is 5). This does not take into account the
#'   number of exceptions retried by botocore.
#' - `max_io_queue`: The maximum amount of read parts that can be queued in memory
#'   to be written for a download. The size of each of these read parts is at most
#'   the size of io_chunksize.
#' - `io_chunksize`: The max size of each chunk in the io queue. Currently, this
#'   is size used when read is called on the downloaded stream as well.
#' - `use_threads`: If `TRUE`, threads will be used when performing S3 transfers.
#'   If `FALSE`, no threads will be used in performing transfers: all logic will
#'   be ran in the main thread.
#' @param aws_access_key_id AWS access key id
#' @param aws_secret_access_key AWS secret access key
#' @param aws_session_token AWS session token
#' @param region_name region name
#' @param profile_name profile name
#' @references <https://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.download_file>
#' @export
#' @examples \dontrun{
#' upload_file('/tmp/hello.txt', 'mybucket', 'hello.txt')
#' }
upload_file <- function(filename,
                        bucket,
                        key,
                        extra_args = NULL,
                        transfer_config = list(
                          multipart_threshold = 8388608L,
                          max_concurrency = 10L,
                          multipart_chunksize = 8388608L,
                          num_download_attempts = 5L,
                          max_io_queue = 100L,
                          io_chunksize = 262144L,
                          use_threads = TRUE
                        ),
                        aws_access_key_id = NULL,
                        aws_secret_access_key = NULL,
                        aws_session_token = NULL,
                        region_name = NULL,
                        profile_name = NULL) {

  boto3$session$Session(
    aws_access_key_id = aws_access_key_id,
    aws_secret_access_key = aws_secret_access_key,
    aws_session_token = aws_session_token,
    region_name = region_name,
    profile_name = profile_name
  ) -> session

  s3 <- session$client("s3")

  boto3$s3$transfer$TransferConfig(
    multipart_threshold = as.integer(transfer_config$multipart_threshold),
    max_concurrency = as.integer(transfer_config$max_concurrency),
    multipart_chunksize = as.integer(transfer_config$multipart_chunksize),
    num_download_attempts = as.integer(transfer_config$num_download_attempts),
    max_io_queue = as.integer(transfer_config$max_io_queue),
    io_chunksize = as.integer(transfer_config$io_chunksize),
    use_threads = transfer_config$use_threads
  ) -> tc

  s3$upload_file(
    Filename = filename,
    Bucket = bucket,
    Key = key,
    ExtraArgs = extra_args,
    Config = tc
  ) -> res

  invisible(res)

}

