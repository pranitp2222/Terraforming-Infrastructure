# Week-04 Lab

## Objectives

* Demonstrate the creation of a managed shell script for the deployment of cloud resources
* Demonstrate the termination of cloud resources in an automated fashion
* Demonstrate the use of positional parameters for dynamic variable creation in a shell script

## Links to Use

* [AWS CLI Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage aws cli sdk")
* [How to install Wordpress](https://developer.wordpress.org/advanced-administration/before-install/howto-install/ "webpage for installing Wordpress")
* [Install aws-cli v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html "webpage how to install aws-cli v2")

## Part 1

Use the `ubuntu/jammy64` Vagrant box your created and configured your aws-cli on.

* Change the hostname to a hostname that includes: your initials and the course.
  * For example: `jrh-444`
  * Use the command: `sudo hostnamectl set-hostname jrh-444`
* Add screenshot to this document
  ![host](https://github.com/illinoistech-itm/ppatil19/blob/main/ITMO-544/Week04-%20AWS%20CLI/image/Screenshot%202023-09-13%20at%203.34.15%20PM.png)

* Install the `aws-cli` tools
  * Take a screenshot of the command `aws version`
  * Place screenshot here

![aws](https://github.com/illinoistech-itm/ppatil19/blob/main/ITMO-544/Week04-%20AWS%20CLI/image/Screenshot%202023-09-13%20at%204.02.25%20PM.png)

## Part 2

### Steps to take

From the AWS Cli on your Vagrant Box

* Pass all variables via the commandline and access them via positional parameters
  * Create and add a new key-pair
  * Create a security group and open remote ports (80)
  * Create an EC2 instance 
  * Create a `user-data` script that installs an Nginx webserver and MySQL server
    * You will need to manually configure Wordpress
* Create a script that will terminate all your launched resources (don't leave this running longer than it has to, as it is not very secure!)

## Part 3

* Create a Wordpress blog post using the content of the Readme.md (where you introduced yourself). Take a screenshot of a this blog post in Wordpress, properly formatted and showing the URL.
  * Place screenshot here

![wp](https://github.com/illinoistech-itm/ppatil19/blob/main/ITMO-544/Week04-%20AWS%20CLI/image/Screenshot%202023-09-19%20at%205.33.37%20PM.png)

![wp](https://github.com/illinoistech-itm/ppatil19/blob/main/ITMO-544/Week04-%20AWS%20CLI/image/Screenshot%202023-09-19%20at%205.34.48%20PM.png)

![wp](https://github.com/illinoistech-itm/ppatil19/blob/main/ITMO-544/Week04-%20AWS%20CLI/image/Screenshot%202023-09-19%20at%205.35.00%20PM.png)
## Deliverables

Create a folder named: `week-04` under your class folder in the provided private repo. In the folder there will be three shell scripts:

* `create-env.sh`
  * This script will create an EC2 instance that installs an Apache Web Server on launch
  * A second shell script named: `install-env.sh` will install the Apache 2 webserver
* `destroy-env.sh`
  * This script will terminate all infrastructure you have created
* I will test this script by using my own account information

Submit the URL to the week-04 folder to Blackboard
