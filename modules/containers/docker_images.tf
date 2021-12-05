resource "docker_registry_image" "TestProjectImages" {
  for_each  = toset(var.docker_tags)
  name      = "${aws_ecr_repository.test_project.repository_url}:${each.value}"
  build {
    context  = "${var.build_context}/${each.value}"
  }
}