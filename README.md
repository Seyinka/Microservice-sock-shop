# Deployment of the Socks Shop Microservices Application on Kubernetes with Infrastructure as Code
## Project Overview
This project involves deploying the Socks Shop microservices-based application using a comprehensive Infrastructure as Code (IaC) approach. The goal is to automate the provisioning and management of resources on AWS and deploy the application securely on Kubernetes. Key components include Terraform for infrastructure provisioning, GitHub Actions for CI/CD pipelines, and Helm for Kubernetes package management. The deployment will also incorporate Prometheus for monitoring, the ELK Stack for logging, and Ansible for security configurations. HTTPS access will be secured using Let's Encrypt.

## Project Prerequisites
Before beginning this project, ensure the following tools are installed and configured:

Helm: A package manager for Kubernetes, used for managing application deployments.

kubectl: The Kubernetes command-line tool, necessary for interacting with the cluster.

Terraform: An IaC tool for automating cloud resource provisioning.

Ansible: An automation tool for configuration management, used to secure the infrastructure.

Kubernetes Cluster: A running Kubernetes cluster, which can be provisioned on platforms like EKS (Amazon), GKE (Google Cloud), AKS (Azure), or Minikube for local development.

## Technology Stack

The deployment leverages the following technologies:

Terraform: This declarative tool will be used to automate the provisioning of AWS resources, including VPCs, subnets, security groups, and an EKS cluster.

AWS: The cloud provider where the infrastructure components will be deployed.

GitHub Actions: Used to automate the CI/CD pipeline, enabling seamless deployment of the Socks Shop application to the Kubernetes cluster.

Kubernetes: The platform for orchestrating the deployment, scaling, and management of the containerized Socks Shop application.

Helm: Aids in managing the Kubernetes deployment by simplifying the installation, upgrade, and rollback of application packages.

Prometheus: A monitoring tool that collects and analyzes metrics from various services, providing insights into application performance.

ELK Stack: A suite of tools (Elasticsearch, Logstash, and Kibana) for real-time log collection, searching, analysis, and visualization.

Let's Encrypt: Provides free SSL/TLS certificates to secure communication with the Socks Shop application over HTTPS.

Socks Shop Application: A microservices-based e-commerce platform that serves as a reference for deploying cloud-native applications.

## Project Output
### The project output covers the comprehensive deployment and management of the Socks Shop application.

AWS Infrastructure (Terraform)
: Automate AWS setup.
Includes: VPCs, subnets, EKS cluster, IAM roles.

CI/CD Pipeline (GitHub Actions) : Automate builds and deployments.
Includes: Build and test workflows, deployment scripts, Terraform integration.

Kubernetes Deployment Files : Deploy the Socks Shop app.
Includes: YAML manifests, services, and Ingress configurations.

Prometheus Monitoring : Monitor application performance.
Includes: Prometheus setup, metrics collection, and alerting rules.

ELK Stack Logging : Centralize and analyze logs.
Includes: Logstash, Elasticsearch, and Kibana configurations.

Ansible Security Playbooks : Automate security practices.
Includes: Security group configurations, system hardening.

Documentation : Guide setup and management.
Includes: Terraform deployment, CI/CD, Kubernetes, Prometheus, ELK Stack, and Ansible usage.
## Getting Started :

### Infrastructure Provisioning:
Socks Shop Resources: [GitHub Repo](https://github.com/microservices-demo/microservices-demo.github.io)

Demo: [Socks Shop Demo](https://github.com/microservices-demo/microservices-demo/tree/master)


Use Terraform to set up AWS infrastructure, including VPCs, subnets, security groups, and an EKS cluster for a consistent and repeatable environment.

Requirements:

Terraform: [Download](https://developer.hashicorp.com/terraform/install)

AWS CLI: [Installation Guide](https://aws.amazon.com/cli/)

Helm : [Helm Installation Guide](https://helm.sh/docs/intro/install/)


## The Process.
1. To carry out this project, it is expected that you have a working directory. Thus using the command `mkdir <your-directory-name>` to create one.

2. Setting up terraform :
create a directory for your terraform files, within the directory create a `main.tf` file using the `touch main.tf` command in your CLI to hold the content of what provisions the Eks cluster and creates other resources needed with the AWS console.

3. To set up your Eks Cluster Provisioning : [Steps to Provision an EKS cluster using Terraform](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest).     You can apply the configurations in the Link to provision your cluster and make adjustments according to your needs. Save the file.

4. Initialize terraform : the `terraform init` command is the first command that you should run after writing your Terraform configuration files. It initializes a Terraform working directory, which is essential for managing your infrastructure with Terraform.![](./images/terraform%20init.png)

5. The `terraform plan` command is used to create an execution plan, showing what Terraform will do when you run terraform apply.![](./images/terraform%20plan.png)

Then run the `terraform apply` command or use the automatic approval flag : `terraform apply --auto-approve`. Once the command is executed, you'll get an output like this:![](./images/Terraform%20apply%20done.png)

## Deploying the webapp 

Create a Kubernetes directory `mkdir kubernetes`. This directory contains your deployment and ingress files. In this project, the files are saved as `sockshop-deployment.yaml` and `sockshop-ingress.yaml`.

6. Connect kubectl with your EKS cluster for interaction within the CLI. This contains `-- name <cluster name>` and `-- region <your region>` as specified in the `main.tf` file. ![](./images/Connect%20Kubectl%20to%20eks.png)

7. Deploy the webapp: the contents of the `deployment.yaml` file contains what would be deployed into the EKS cluster. Thus apply the deployment file to your clust.er![](./images/SockShop%20deploy.png)

8. Helm : ensure helm is installed using the `helm version` command ![](./images/Helm.png) If not installed follow the helm installation guide above to install helm.

Then add Helm repo : ![](./images/helm%20repo%20add.png)
![](./images/helm%20repo%20update.png)

 9. Install the NGINX Ingress Controller on a Kubernetes cluster using Helm, a package manager for Kubernetes.
![](./images/install%20helm%20repo.png)

10. Then run command `kubectl config set-context --current --namespace=sock-shop` to set the default namespace for the current Kubernetes context.

11. Apply the Ingress file : within the kubernetes directory run `kubectl apply -f <your-ingress.yaml>` file.

12. You get get the webapp page by port forwarding the front-end service: Run the command in the image below:![](./images/port%20forward.png)
 Which then serves the front-end page of the application in the brower.![](./images/served%20sockshop%20frontend.png)

13. Configure your DNS if you have a domain name. After applying the ongress file run `kubectl get pods,svc` to get the load balancer link that looks like this : (a23******************.us-east-1.elb.amazonaws.com). 

Then navigate to your Domain name Management, create CName records, host (@), values (the loadbalancer link), TTl( set to automatic or anytime you desire). save changes.![](./images/cname.png)

Then, reapply `youringress.yaml file` and run your domain name in your browser. This will serve the app as Http. ![](./images/seyitan.me%20.png).

## Certificates
In Kubernetes, certificates are used for securing communication between various components and for managing access control.

 Getting certificates: ![](./images/getting%20cert%20manager.png)

- Run the command to add jetstack repo.![](./images/jetstack%20install.png)
- Then run `helm repo update`

 14. Create a yaml file using the `touch` command for your clusterissuer. In this project, it is specified as `clusterissuer.yaml` and fill it with contents needed and then edit your ingress.yaml file to contain your clusterissuer details and apply both the `clusterissuer.yaml` and `your ingress.yaml` files.![](./images/Apply%20clusterissuer%20and%20ingress.yaml%20files.png)

 15. Run `kubectl describe clusterissuer letsencrypt-prod`. This command provides detailed information about the specified resource, including its configuration and status.![](./images/describ%20clusterissuer.png)

 16. Command `kubectl describe ingress sock-ingress -n sock-shop`. This command provides detailed information about the specified Ingress, including its configuration, rules, and status.![](./images/describe%20ingress%20sock-ingress%20-n%20sock.png)

 17. Command `kubectl get certificates -n sock-shop`.This command will show you an overview of all Certificate resources in that namespace, including their names and status.![](./images/get%20certificates.png)

 18. Try domain name with HTTPS:![](./images/Webpage%20with%20encryption.png)

 ## Network poilcy
  Network Policies in Kubernetes allow you to control the traffic flow between pods and between pods and other network endpoints.
  
   Create a yaml file for network policies. `touch network-policies.yaml` and apply the file.![](./images/network%20policy.png)

   ## Ansible for extra security
   Ensure that ansible is installed. Use the `ansible version` command.
   If not installed, prompt chatgpt or any AI tool to guide.

   Create a `playbook.yaml` file and a `secrets.yaml` file. ![](./images/Ansible%20vault%20for%20extra%20security.png)

   ## Monitoring
   For Monitoring, Prometheus and Grafana are the tools used. 
   
   Run the commands to get your monitoring tools installed. This also comes ith alertmanager.![](./images/helm%20repo%20add%20prometheus.png)

- Then run command `helm install prometheus prometheus/kube-prometheus-stack -n sock-shop`. The command installs the kube-prometheus-stack Helm chart from the Prometheus Community repository into the sock-shop namespace. This chart deploys Prometheus, Grafana, and related components for monitoring and alerting in Kubernetes.

- Run `helm repo update` to get the lastest information on help repositories.

- Next is to run `kubectl get pods -n sock-shop
` to see pods related to Prometheus and Grafana and Alertmanager.

## Setting Up Your Domain (DNS)
- Load Balancer IP: Get the load balancer Ip adresses using the `nslookup a23******************.us-east-1.elb.amazonaws.com`
This ouputs the ip address of the load balancer.

- Go to you DNS management, and set up your A records and CName records for your monitoring. ![](./images/Records.png)

- Update `your-ingress.yaml`file to add grafana, prometheus, and alertmanager as hosts with their respectuve pods and domain name configuration.

-  Then apply `your-ingress.yaml` file with the `kubectl apply -f <youringress.yaml> `command.

Navigate to your browser, just as updated in the Ingress.yaml file, and check the hosts tht holds the domain name.
- For prometheus : promitheus.seyitan.me ![](./images/prometheus.seyitan.me.png)

- For Grafana : grafana.seyitan.me![](./images/grafana.seyitan.me.png)

- For Alertmanager :![](./images/alertmanager.seyitan.me.png)


## Conclusion
In this project, we effectively deployed the Socks Shop microservices application using a modern Infrastructure as Code (IaC) approach.

## Key Accomplishments:
Infrastructure Provisioning: Automated AWS infrastructure setup with Terraform, including VPCs, subnets, and an EKS cluster.

CI/CD Pipeline: Implemented GitHub Actions for automated build, test, and deployment, integrating Terraform for seamless infrastructure management.

Kubernetes Deployment: Deployed Socks Shop on Kubernetes with proper configurations for deployments, services, and Ingress.

Monitoring and Alerting: Set up Prometheus and Grafana for real-time monitoring and alerting.
Logging: Integrated the ELK Stack for centralized log management and analysis.

Security: Applied security best practices using Ansible, network policies, and ensured HTTPS with Let's Encrypt.

DNS Configuration: Configured domain names and DNS records for secure application access.

### Lessons Learned:
Automation Efficiency: IaC tools like Terraform and Helm streamline deployment and reduce errors.

Monitoring and Security: Early integration of monitoring and security practices is crucial for maintaining performance and protection.

Documentation and Maintenance: Thorough documentation is key for managing complex deployments and troubleshooting.

This project highlights the effectiveness of modern DevOps practices in creating a scalable, secure, and efficient deployment pipeline for microservices applications on Kubernetes.