# Flask Application CI/CD pipeline
This repository contains all the necessary code to set up a complete CI/CD pipeline for a simple Flask application.
You can choose jenkins or gitlab to build your CI/CD pipeline.

The application reads an uploaded file and returns the file format.

## The pipeline includes the following stages:

Build: The code is built into a Docker image, which is then tagged with the specified registry, image name, and tag.
Test: The tests for the application are run inside the Docker image.
Push: The image is pushed to a private DockerHub repository.
Deploy: The new image is deployed to a specified Kubernetes cluster by applying the deployment and service manifests.
Jenkinsfile
The Jenkinsfile defines the pipeline in Jenkins. It includes the following stages:

Checkout: The code is checked out from a git repository.
Build and Push: The Docker image is built and pushed to the specified registry.
Deploy: The new image is deployed to the specified Kubernetes cluster.
The Jenkinsfile uses the Jenkins kubeconfig plugin to manage access to the Kubernetes cluster. This plugin allows the use of a Kubernetes configuration file stored in Jenkins credentials to authenticate with the cluster.

## gitlab-ci.yml
The .gitlab-ci.yml file defines the pipeline in GitLab CI/CD. It includes the following stages:

Build: The code is built into a Docker image, which is then tagged with the specified registry, image name, and tag.
Test: The tests for the application are run inside the Docker image.
Push: The image is pushed to a private DockerHub repository.
Deploy: The new image is deployed to a specified Kubernetes cluster by applying the deployment and service manifests.
The GitLab CI/CD pipeline uses environment variables to store the credentials for the DockerHub repository and the kubeconfig file.

**It's important to note that these files are examples and you may need to adjust them to match your specific requirements and the configuration of your CI/CD system.

**Also, you should consider adding stages for testing, monitoring, and rollback mechanisms in a real-world scenario.

## How to use
1. Clone this repository
2. pip3 install -r requirements.txt
3. Set up your CI/CD system and configure it to use the Jenkinsfile or .gitlab-ci.yml file
4. Add the necessary environment variables and credentials to your CI/CD system
5. Run the pipeline and see the application being built, tested, pushed, and deployed.
6. Make sure to have the necessary dependencies and configurations to run the application on your local system.
7. Make sure that your Kubernetes cluster is set up and configured properly to receive the deployments.
8. Customize the pipeline to match your specific requirements and configurations.
9. Consider adding stages for testing, monitoring, and rollback mechanisms in a real-world scenario.
10. Regularly update and maintain the pipeline to ensure smooth and efficient deployments.
11. It's important to note that this pipeline is intended as a starting point, and you may need to make adjustments to fit your specific use case. Additionally, it is recommended to test the pipeline thoroughly before using it in production to ensure that everything is working as expected.

##### Have a nice day!
