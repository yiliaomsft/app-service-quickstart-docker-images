# Web App for Containers quick start docker images

This repo contains all currently quick start docker images contributed by the community.	

## Contribution guide

Please follow the guidelines to be compliant . If any docker image is out of compliance , it will be **blacklisted** from this repo and eventually removed. 

## Files, folders and naming conventions
1. Create a new folder for a new docker image and include a version folder . Such as 
```
+my-image
	         \  0.1 
		       \Dockerfile and other files 
		
```
 
 *Note:  If you are updating an existing image  , create a new version folder within your image folder.*
  
2.Include a README.md within version folder to describe :
		a. Any changes with deployment of use of the image 
		b. Include comments if the image is not backward compatible and how user can manually upgrade to new version 


+ [**Best practices**](/contribution-guide/best-practices.md). Best practices for improving the quality of your docker image
+ [**Git tutorial**](/contribution-guide/git-tutorial.md). Step by step to get you started with Git.
+ [**Useful Tools**](/contribution-guide/useful-tools.md). Useful resources and tools for docker image development

## Submission workflow 
The submission process 6 step process as shown below. The time taken to approve or reject a PR can vary as this is community driven. 

![Submission workflow for docker images](images/submission-flow.PNG?raw=true)

### Explaintion of setup 6 "Automated Deployment to Docker hub":

The related image would be deployed to Docker hub automatically as soon as commit message include string "#sign-off". 
Below 2 kinds of tags would be set.
1. Set tag as the value of version folder name. For example:
```
Update files which under ..\my-image\0.1, 
it would push my-image:0.1 to Docker hub.
```
2. Set tag as "latest".
- There is 1 file names latest.txt exist under image folder.
- The value of above file is as same as the related image version.
For example: 
```
Update files which under ..\my-image\0.1, 
..\my-image\latest.txt is exist and the content is "0.1", 
it would also push my-image:latest to Docker hub.
```

## Deploying Samples
You can deploy these samples directly through the Azure Portal

1. Go to [Azure portal](https://portal.azure.com)
2. Search for [Web app for Containers](https://portal.azure.com#create/microsoft.appsvclinux)
3. Enter web app name , susbcription , resource group 
4. Select configure container and enter the docker hub image name with the tag name. you can find all the docker hub images [here](https://hub.docker.com/r/appsvcorg) 
5. Review the readme.md for the imae you are using to make sure any additional configuration such as app settings need to be updated. Make the necessary changes 
6. Now browse the application 

*Note: The first request can take longer to complete since the docker image needs to be pulled and run on the container for the first request. This can occur when you scale up your application or the instance gets recycled.*


