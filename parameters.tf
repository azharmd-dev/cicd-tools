resource "aws_ssm_parameter" "jenkins_agent_sg" {
  name  = "/${var.project}/${var.environment}/jenkins_agent_sg_id"
  type  = "String"
  value = aws_security_group.main.id
}