output "bastion_public_ip" {
  value = module.bastion_instance.public_ip
}
output "bastion_private_ip" {
  value = module.bastion_instance.private_ip
}
output "vpn_public_ip" {
  value = module.vpn_instance.public_ip
}
output "vpn_private_ip" {
  value = module.vpn_instance.private_ip
}