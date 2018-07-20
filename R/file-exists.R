#' Test if a file exists in the specified bucket
#'
#' @md
#' @param bucket name of the bucket to download from.
#' @param key name of the key (file).
#' @param aws_access_key_id AWS access key id
#' @param aws_secret_access_key AWS secret access key
#' @param aws_session_token AWS session token
#' @param region_name region name
#' @param profile_name profile name
#' @references <https://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.download_file>
#' @export
#' @examples \dontrun{
#' file_exists("mybucket", "hello.txt")
#' }
file_exists <- function(bucket,
                        key,
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

  s3$list_objects_v2(
    Bucket = bucket,
    Prefix = key,
    MaxKeys = 1L
  ) -> res

  return(res$KeyCount != 0)

}