output "instance_public_ip" {
    description = "Public IP of the Minecraft EC2 instance"
    value = aws_instance.minecraft_instance.public_ip
}

output "key_name" {
    description = "Name of the SSH key pair used"
    value = aws_key_pair.minecraft_key.key_name
}
