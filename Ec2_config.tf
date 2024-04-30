# Fetch existing key pair
data "aws_key_pair" "existing_key_pair" {
  key_name = "test"  # Update with the name of your existing key pair
}


resource "aws_instance" "turplinkgroups_EC2" {
  count          = var.quantity
   ami           = "ami-04e5276ebb8451442"
  #  key_name         = data.aws_key_pair.existing_key_pair.id
   instance_type = "t2.micro"
   subnet_id     = aws_subnet.public_turplink_subnet[count.index].id
   security_groups    = [aws_security_group.public_turplink_sg.id]
   availability_zone = var.availability_zone[count.index]
   associate_public_ip_address = true
    # User data script to install updates and a web server (optional)
   user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    cat > /var/www/html/index.html << 'END'
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to Our Site</title>
        <style>
            body { font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 40px; }
            h1 { color: #333366; }
            p { color: #666; font-size: 1.2em; }
            .content { background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
            .button { padding: 10px 20px; background-color: #0084ff; color: white; border: none; border-radius: 5px; cursor: pointer; }
            .button:hover { background-color: #0056b3; }
        </style>
    </head>
    <body>
        <div class="content">
            <h1>Welcome to Our Web Service!</h1>
            <p>Today's date is <span id="date"></span>.</p>
            <p>Click the button to change the greeting:</p>
            <button class="button" onclick="changeGreeting()">Change Greeting</button>
            <p id="greeting">Hello, visitor!</p>
        </div>
        
        <script>
            document.getElementById('date').innerText = new Date().toDateString();
            
            function changeGreeting() {
                const greetings = ["Hello, world!", "Welcome to our website!", "Enjoy your stay!", "Greetings from the cloud!"];
                const greeting = greetings[Math.floor(Math.random() * greetings.length)];
                document.getElementById('greeting').innerText = greeting;
            }
        </script>
    </body>
    </html>
    END
  EOF

 tags = {
Name = "TurplinkServer"
  }
}
