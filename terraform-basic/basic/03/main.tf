variable "file_name" {
  default = "step0.txt"
}

resource "local_file" "abc" {
  content  = "lifecycle - step 6"
  filename = "${path.module}/${var.file_name}"

  lifecycle {
    precondition {
      condition     = var.file_name == "step6.txt" || var.file_name == "step5.txt" || var.file_name == "step4.txt" || var.file_name == "step3.txt" || var.file_name == "step2.txt" || var.file_name == "step1.txt" || var.file_name == "step0.txt"
      error_message = "file name is not \"step6.txt\""
    }
  }
}