# task3-minikube

1.	Deploy Minikube
2.	Deploy Jenkins into you k8s cluster via helm/helmfile
3.	Install Jenkins k8s plugin
4.	Create 2 namespaces, dev and prod
5.	Write pipeline that will:
 - implement hadolint check
 - build Docker image in k8s agent (it can be basic python app for example) 
 - implement image substitution in the helm chart before pushing to the Chartmuseum
 - deploy helm chart from Chartmuseum into k8s (perform install or rolling upgrade if already installed)
6.	Modify your pipeline using ENV vars, so it will deploy your app differently, depending on ENV vars:
 - with 1 replica if ENV = dev, 3 replicas if ENV = prod
 - app should be deployed in different namespaces depending on same ENV var
 - add 2 Jenkins secrets (some passwords) for dev and prod
 - pass different k8s secrets (previously created passwords) depending on same ENV var

![image](https://user-images.githubusercontent.com/25955232/136226104-40219e3f-df84-4e80-8e60-291d8281913c.png)
