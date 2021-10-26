pipeline {
    agent {
        kubernetes {
            // Rather than inline YAML, in a multibranch Pipeline you could use: yamlFile 'jenkins-pod.yaml'
            // Or, to avoid YAML:
            // containerTemplate {
            //     name 'shell'
            //     image 'ubuntu'
            //     command 'sleep'
            //     args 'infinity'
            // }
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: shell
    image: ubuntu
    command:
    - sleep
    args:
    - infinity
  - name: hadolint
    image: hadolint/hadolint:latest-debian
    imagePullPolicy: Always
    command:
    - cat
    tty: true
  - name: docker
    image: docker:19.03.1-dind
    securityContext:
      privileged: true
    env:
      - name: DOCKER_TLS_CERTDIR
        value: ""
'''
            // Can also wrap individual steps:
            // container('shell') {
            //     sh 'hostname'
            // }
            defaultContainer 'shell'
        }
    }
    environment{
        TEST_VAR = "testvar"
    }
    stages {
        stage("Test"){
            steps{
                container('shell'){
                    sh '${env.TEST_VAR}'
                }
            }
        }
        stage('Hadolint Dockerfile') {
            steps {
                container('hadolint') {
                    sh 'hadolint dockerfiles/* | tee -a hadolint_lint.txt'
                }
            }
            post {
                always {
                    archiveArtifacts 'hadolint_lint.txt'
                }
            }
        }
        stage('Build Image') {
            steps {
                git 'https://github.com/nginxinc/docker-nginx.git'
                container('docker') {
                    sh 'docker version && cd stable/alpine/ && docker build -t nginx-example .'
                }
            }
        }
    }
}
