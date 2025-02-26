pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'version', defaultValue: '', description: 'version of artifact')
        string(name: 'environment', defaultValue: 'dev', description: 'Which environment?')
        booleanParam(name: 'Destroy', defaultValue: 'false', description: 'destroy all')
        booleanParam(name: 'Create', defaultValue: 'false', description: 'create')
    }
    // build
    stages {
        stage('print the version') {
            steps {
                sh """
                    echo "version: ${params.version}"
                    echo "environment: ${params.environment}"
                """
            }
        }
        stage('init') {
            steps {
                sh """
                    cd terraform
                    terraform init --backend-config=${params.environment}/backend.tf -reconfigure 
                """
            }
        }
        stage('plan') {
            steps {
                sh """
                    cd terraform
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" 
                """
            }
        }
         stage('apply') {
            when{
                expression{
                    params.Create
                }
            }
            steps {
                sh """
                    cd terraform
                    terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }
        stage('destroy') {
            when {
                expression {
                    params.Destroy
                }
            }
            steps {
                sh """
                    cd terraform
                    terraform destroy -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${param.version}" -auto-approve
                """
            }
        }
    }

    // post build
    post { 
        always { 
            echo 'pipeline succes or fail i will appear'
            deleteDir()
        }
        failure { 
            echo 'this pipeline is failed'
        }
        success{
            echo 'this pipeline is success'
        }
    }
}