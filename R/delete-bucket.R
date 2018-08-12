#' Delete an S3 bucket
#'
#' Deletes the bucket. All objects (including all object versions and Delete Markers)
#' in the bucket must be deleted before the bucket itself can be deleted.
#'
#' @md
#' @param bucket name of the bucket
#' @param aws_access_key_id AWS access key id
#' @param aws_secret_access_key AWS secret access key
#' @param aws_session_token AWS session token
#' @param profile_name profile name
#' @return the API call result structure (invisibly). The `Location` element will
#'        have the bucket name if the call was successful.
#' @references <https://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.create_bucket>
#' @export
#' @examples \dontrun{
#' }
delete_bucket <- function(bucket,
                          aws_access_key_id = NULL,
                          aws_secret_access_key = NULL,
                          aws_session_token = NULL,
                          region_name = NULL,
                          profile_name = NULL) {

  boto3$session$Session(
    aws_access_key_id = aws_access_key_id,
    aws_secret_access_key = aws_secret_access_key,
    aws_session_token = aws_session_token,
    profile_name = profile_name
  ) -> session

  s3 <- session$client("s3")

  s3$delete_bucket(Bucket = bucket) -> res

  invisible(res)

}

