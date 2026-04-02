pipeline {
    agent any
    parameters {
	booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
	choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    }

    environment {
	TF_VAR_proxmox_api_token = credentials('proxmox_api_token')
	TF_VAR_ssh_public_key    = credentials('ssh_public_key')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/eliseo-lopez-bravo/terraform-proxmox-vm-ubuntu.git', branch: 'main'
            }
        }

	stage('Terraform init'){
	    steps{
		sh 'terraform init'
	    }
	}
	stage('Plan'){
	    steps{
		sh 'export TF_INPUT=false'
                sh 'terraform ${action} -var-file=./variables.tf -auto-approve'
	    }
	}
        stage('Terraform Apply') {
            steps {
		script {
		    if (params.action == 'apply') {
		        sh 'terraform ${action} -input=false tfplan'
		    } else if (params.action == 'destroy') {
                        sh 'terraform ${action} -var-file=./vars/dev.tfvars -auto-approve'
		    } else {
			error "Invalid action selected. Please choose either 'apply' or 'destroy'."
		    }

		}    
            }
        }
    }
}
