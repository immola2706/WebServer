String credentialsId = 'awsCredentials'

try {
    stage('checkout') {
        node {
            cleanWs()
            checkout scm
        }
    }


    stages {

        stage('terraform started') {
            steps {
                sh 'echo "Started...!" '
            }
        }
        stage('git clone') {
            steps {
                sh 'sudo rm -r *;sudo git clone https://github.com/immola2706/WebServer.git'
            }
        }

// Run terraform init
    stage('init') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
            ]]) {
                sh 'sudo /home/ec2-user/terraform init'
            }
        }
    }

// Run terraform plan
    stage('plan') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
            ]]) {
                sh 'terraform plan'
            }
        }
    }

    if (env.BRANCH_NAME == 'master') {
// Run terraform apply
    stage('apply') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
            ]]) {
                sh 'terraform apply -auto-approve'
            }
        }
    }
// Run terraform show
    stage('show') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
             ]]) {
                sh 'terraform show'
            }
        }
    }
}

currentBuild.result = 'Success'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
    currentBuild.result = 'Aborted'
}
catch (error) {
    currentBuild.result = 'Failure'
    throw error
}
finally {
    if (currentBuild.result == 'Success') {
       currentBuild.result = 'Success' 
    }
}
}
