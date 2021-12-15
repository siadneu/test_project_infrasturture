resource "aws_route53_zone" "dns" {
  name = var.domain_name
}

resource "aws_route53_record" "frontend" {
  name    = var.domain_name
  type    = "A"
  zone_id = aws_route53_zone.dns.id
  alias {
    evaluate_target_health = true
    name                   = var.alb_name
    zone_id                = var.alb_zone_id
  }
}

resource "aws_route53_record" "backend" {
  name    = "api.${var.domain_name}"
  type    = "A"
  zone_id = aws_route53_zone.dns.zone_id
  alias {
    evaluate_target_health = true
    name                   = var.alb_name
    zone_id                = var.alb_zone_id
  }
}

resource "aws_route53_record" "frontend_with_www" {
  name    = "www.${aws_route53_record.frontend.name}"
  type    = "A"
  zone_id = aws_route53_zone.dns.zone_id
  alias {
    evaluate_target_health = true
    name                   = aws_route53_record.frontend.name
    zone_id                = aws_route53_record.frontend.zone_id
  }
}

resource "aws_route53_record" "backend_with_www" {
  name    = "www.${aws_route53_record.backend.name}"
  type    = "A"
  zone_id = aws_route53_zone.dns.zone_id
  alias {
    evaluate_target_health = true
    name                   = aws_route53_record.backend.name
    zone_id                = aws_route53_record.backend.zone_id
  }
}