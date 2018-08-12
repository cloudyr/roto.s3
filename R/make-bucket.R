#' Create a new S3 bucket
#'
#' To create a bucket, you must register with Amazon S3 and have a valid AWS Access
#' Key ID to authenticate requests. Anonymous requests are never allowed to create
#' buckets. By creating the bucket, you become the bucket owner.
#'
#' By default, the bucket is created in the US East (N. Virginia) region. You can
#' optionally specify a region in the request body.
#'
#' @md
#' @param bucket name of the bucket. Not every string is an acceptable bucket name.
#'        For information on bucket naming restrictions, see
#'        [Working with Amazon S3 Buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html).
#' @param acl the canned ACL to apply to the bucket. Options are "`private`",
#'        "`public-read`", "`public-read-write`", "`aws-exec-read`", "`authenticated-read`",
#'        "`bucket-owner-read`", "`bucket-owner-full-control`". The default is
#'        "`bucket-owner-full-control`".
#' @param location_constraint Specifies the region where the bucket will be created.
#'        If you don't specify a region, the bucket will be created in US Standard.
#' @param grant_full_control,grant_read,grant_read_acp,grant_write,grant_write_acp
#'        grantee strings (optional)
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
create_bucket <- function(bucket,
                          acl = c(
                            "bucket-owner-full-control", "private", "public-read",
                            "public-read-write", "aws-exec-read", "authenticated-read",
                            "bucket-owner-read"
                          ),
                          location_constraint = NULL,
                          grant_full_control = "",
                          grant_read = "",
                          grant_read_acp = "",
                          grant_write = "",
                          grant_write_acp = "",
                          aws_access_key_id = NULL,
                          aws_secret_access_key = NULL,
                          aws_session_token = NULL,
                          region_name = NULL,
                          profile_name = NULL) {

  acl <- match.arg(
    acl[1],
    choices = c(
      "bucket-owner-full-control", "private", "public-read", "public-read-write",
      "aws-exec-read", "authenticated-read", "bucket-owner-read"
    )
  )

  boto3$session$Session(
    aws_access_key_id = aws_access_key_id,
    aws_secret_access_key = aws_secret_access_key,
    aws_session_token = aws_session_token,
    profile_name = profile_name
  ) -> session

  s3 <- session$client("s3")

  if (is.null(location_constraint) || location_constraint == "us-east-1") {
    s3$create_bucket(
      ACL = acl,
      Bucket = bucket,
      GrantFullControl = grant_full_control,
      GrantRead = grant_read,
      GrantReadACP = grant_read_acp,
      GrantWrite = grant_write,
      GrantWriteACP = grant_write_acp
    ) -> res
  } else {
    s3$create_bucket(
      ACL = acl,
      Bucket = bucket,
      CreateBucketConfiguration = list(
        LocationConstraint = location_constraint
      ),
      GrantFullControl = grant_full_control,
      GrantRead = grant_read,
      GrantReadACP = grant_read_acp,
      GrantWrite = grant_write,
      GrantWriteACP = grant_write_acp
    ) -> res

  }

  invisible(res)

}

