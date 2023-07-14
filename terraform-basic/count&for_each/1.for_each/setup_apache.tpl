#!/bin/bash

sudo apt -y update

sudo yum install httpd -y

sudo sed -i 's/Listen 80/Listen ${port_num}/g' /etc/httpd/conf/httpd.conf

sudo tee /var/www/html/index.html <<EOF
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title> LeeJunHo </title>
</head>

<body>
<p> ${my_name} </p>
</body>
</html>
EOF

sudo systemctl enable httpd.service
sudo systemctl start httpd.service 