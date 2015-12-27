# continuous-delivery-pipeline
Simple DevOps Continous Delivery Pipleine for a Ruby and MySQL app using Docker, docker-compose, Jenkins, GitLab, Docker Registry and Snap Creator.

Change docker registry from 10.65.57.126:5000 in all files to your registry 

1) Install and start Gitlab
(For my env I ran it in a docker container on my demo host using https://github.com/sameersbn/docker-gitlab)
2) Create new projects for each of:
	ruby-mysql-web
	ruby-mysql-web-test
	ruby-mysql-web-prod
	ruby-mysql-web-test-with-prod-clone-data

3) Start a jenkins Server

4) Start a Docker Registry

5) Add new jobs to Jenkins for each project

6) add jenkins plugin for Build Pipeline

Check https://github.com/phauer/continuous-delivery-playground to get help on how to setup gitlab, docker regitry , jenkins and build pipeline

