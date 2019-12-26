
(import [storages.backends.s3boto3 [S3Boto3Storage]])

(defclass MediaStorage [S3Boto3Storage]
  [location "media"
   file_overwrite False])

(defclass StaticStorage [S3Boto3Storage]
  [location "static"
   file_overwrite False])
