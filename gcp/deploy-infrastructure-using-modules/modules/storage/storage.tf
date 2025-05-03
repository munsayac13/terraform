resource "google_storage_bucket" "mylocalonebucket" {
  name = "mylocalonebucket" 
  location = "US"
  uniform_bucket_level_access = true
  force_destroy = true
}
