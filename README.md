# Overview
This Scripts repository contains scripts and codes that I author, modify for customer's requirements or for my own learnings. 

## snapshotAzure
  The script creates, restores and deletes snapshots of disks attached to an Azure VM.  

## A bug in az cli version 2.29 [Oct 21]
I recently faced an issue with az CLI during deployment of a function app in my azure devops pipelines. The az cli version 2.29 had a 
bug that did not let the function app to deploy.
We have separate pipelines for each function. For eample - a pipeline for Intune, another pipeline for CSP biling, among others. 
These pipelines use different VMImage fo their deployments. CSP billing uses 'windows latest'.'Intune dataApi' uses 'ubuntu latest'.
These pipelines use templates to describe stages and jobs that are deployed to envrionments such as development, qa and prod.
One such template was for deploying code. This template contained steps for deploying the function app. The deployment needed az cli. 
The pipelines, by default, installs the latest version available. and our pipelines was installing az cli v2.29.0 
I had to determine the OS type of VM Image and then focre version constraint on az cli. 
Below snippet of the code shows how I achieved this using parameters and agent variables.

![image](https://user-images.githubusercontent.com/13200163/146733981-85e5b7d9-7afb-4cca-94f6-ba7541bf9948.png)


