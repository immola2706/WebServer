String credentialsId = 'awsCredentials'

try {
    stage('checkout') {
        node {
            cleanWs()
            checkout scm
        }
    }
// Run terraform init
    stage('init') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
            ]]) {
                "sh 'sudo /var/lib/jenkins/workspace/PipelineNew_master/terraform init'"
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
                "sh '/var/lib/jenkins/workspace/PipelineNew_master/terraform plan"
            }
        }
    }

// Run terraform apply
    stage('apply') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
            ]]) {
                "sh 'sudo /var/lib/jenkins/workspace/PipelineNew_master/terraform apply -auto-approve'"
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
                "sh 'sudo /var/lib/jenkins/workspace/PipelineNew_master/terraform show'"
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
