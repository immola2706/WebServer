String credentialsId = 'awsCredentials'

try {
    stage ('checkout') {
        node {
            cleanWs{}
            checkout scm
        }
    }


// Run terraform init
    stage ('init') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
                ansicolor('xterm') {
                    sh 'sudo /home/ec2-user/terraform init ./jenkins'
                }
            }
        }
    }

// Run terraform plan
    stage ('plan') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
                ansicolor('xterm') {
                    sh 'ls ./jenkins; sudo /home/ec2-user/terraform plan ./jenkins'
                }
            }
        }
    }

    if (env.BRANCH_NAME == 'master') {
// Run terraform apply
    stage ('apply') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
                ansicolor('xterm') {
                    sh 'sudo /home/ec2-user/terraform apply -auto-approve'
                }
            }
        }
    }
// Run terraform show
    stage ('show') {
        node {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'awsCredentials',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
                ansicolor('xterm') {
                    sh 'sudo /home/ec2-user/terraform show'
                }
            }
        }
    }
}

currentBuild.result = 'Success'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
    currentBuild.result = 'Aborted'
}
catch ('error') {
    currentBuild.result = 'Failure'
    throw error
}
finally {
    if (currentBuild.result == 'Success') {
       currentBuild.result = 'Success' 
    }
}
