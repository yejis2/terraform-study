# tfe ec2 에 사용할 ec2 ssm role 생성
data "aws_iam_policy_document" "ec2_ssm_assume_role_policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name               = "${local.project_name}-role-ec2ssm"
  assume_role_policy = data.aws_iam_policy_document.ec2_ssm_assume_role_policy.json
  tags = { Name = "${local.project_name}-role-ec2ssm" }
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_instance_profile" "iam_inst_profile" {
  name = "${local.project_name}-iam-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}
