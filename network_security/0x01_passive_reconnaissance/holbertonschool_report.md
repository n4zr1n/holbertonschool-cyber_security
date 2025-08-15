Holberton School - Reconnaissance Summary (from Shodan Data)

Subdomains, IPs, Locations, and Hosting Info

Subdomain:                          IP address:       Hostname:                                            Provider:                       Location:
- yriry2.holbertonschool.com          52.47.143.83      ec2-52-47-143-83.eu-west-3.compute.amazonaws.com     Amazon Data Services France     Paris, France
- staging-apply.holbertonschool.com   13.37.67.17       ec2-13-37-67-17.eu-west-3.compute.amazonaws.com      Amazon Data Services France     Paris, France    
- apply.holbertonschool.com           15.188.218.54     ec2-15-188-218-54.eu-west-3.compute.amazonaws.com    Amazon Data Services France     Paris, France  
- apply.holbertonschool.com           13.37.181.187     ec2-13-37-181-187.eu-west-3.compute.amazonaws.com    Amazon Data Services France     Paris, France  
- read.holbertonschool.com            15.236.251.91     ec2-15-236-251-91.eu-west-3.compute.amazonaws.com    Amazon Data Services France     Paris, France  
- vstaging-apply.holbertonschool.com   35.181.42.84      ec2-35-181-42-84.eu-west-3.compute.amazonaws.com     Amazon Data Services France     Paris, France   
- apply.holbertonschool.com           51.44.231.239     ec2-51-44-231-239.eu-west-3.compute.amazonaws.com    A100 ROW Inc                    Paris, France   
- staging-apply.holbertonschool.com   13.38.221.164     ec2-13-38-221-164.eu-west-3.compute.amazonaws.com    Amazon Data Services France     Paris, France  
- read.holbertonschool.com            15.188.124.24     ec2-15-188-124-24.eu-west-3.compute.amazonaws.com    Amazon Data Services France     Paris, France  
- apply.holbertonschool.com           15.188.230.158    ec2-15-188-230-158.eu-west-3.compute.amazonaws.com   Amazon Data Services France     Paris, France 


SSL Certificate Information

Subdomain:                         Issued By:                 Issued To (CN):                     TLS Versions:
yriry2.holbertonschool.com         Let's Encrypt              yriry2.holbertonschool.com          TLSv1.2, TLSv1.3 
staging-apply.holbertonschool.com  Amazon RSA 2048 M04        staging-apply.holbertonschool.com   TLSv1.2        
apply.holbertonschool.com          Amazon RSA 2048 M03        apply.holbertonschool.com           TLSv1.2        
read.holbertonschool.com           Amazon RSA 2048 M03        read.holbertonschool.com            TLSv1.2        


Web Server & Headers
Web Server: nginx / nginx/1.20.0
Security Headers Present:

- "X-Frame-Options: SAMEORIGIN"
- "X-XSS-Protection: 1; mode=block" or "0"
- "X-Content-Type-Options: nosniff"
- "X-Download-Options: noopen"
- "Strict-Transport-Security" (sometimes present)


Observed Technologies and Behaviors

- Web Server: Nginx
- TLS Versions: Mostly TLSv1.2; one instance of TLSv1.3
- Frameworks: Not directly visible from Shodan; likely custom apps with Nginx reverse proxy
- Access Control: Some endpoints return "401 Unauthorized", indicating authenticated APIs or admin panels
- All instances are hosted in Amazon AWS (EC2), in "eu-west-3" (Paris) region


Observed Subdomains

- apply.holbertonschool.com — Primary admissions portal
- staging-apply.holbertonschool.com — Development or staging version of admissions
- read.holbertonschool.com — Possibly content or learning platform
- yriry2.holbertonschool.com — Unknown function, potentially internal


blog.holbertonschool.com 	192.0.78.230  192.0.78.0/24  United States 			
lvl2-discourse-staging.holbertonschool.com 	13.38.216.13  13.36.0.0/14  France
staging-apply-forum.holbertonschool.com 	13.38.122.220  13.36.0.0/14  France
v1.holbertonschool.com 	54.86.136.129  54.86.0.0/16  United States
v2.holbertonschool.com 	34.203.198.145  34.192.0.0/12  United States
yriry2.holbertonschool.com 	52.47.143.83  52.47.0.0/16  France

alt3.aspmx.l.google.com 	142.250.102.27   142.250.102.0/24  United States
alt4.aspmx.l.google.com 	192.178.156.26   192.178.156.0/24 	United States
alt1.aspmx.l.google.com 	172.253.116.27   172.253.116.0/24 	United States
alt2.aspmx.l.google.com 	173.194.76.27   173.194.76.0/24 	United States
aspmx.l.google.com 	172.253.63.27   172.253.63.0/24 	United States

ns-957.awsdns-55.net 	205.251.195.189  205.251.195.0/24 	United States 			
ns-1244.awsdns-27.org 	205.251.196.220  205.251.196.0/24 	United States 			
ns-1991.awsdns-56.co.uk 	205.251.199.199  205.251.199.0/24 	United States 			
ns-343.awsdns-42.com 	205.251.193.87  205.251.193.0/24 	United States
