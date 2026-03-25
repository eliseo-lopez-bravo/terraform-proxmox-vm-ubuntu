pipeline {
    agent any
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

        stage('Run Shell Script') {
            steps {
                sh 'chmod u+x ./hello.sh'
                sh './hello.sh'
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
                sh 'terraform plan -var-file=./vars/dev.tfvars -out tfplan'
	    }
	}
        stage('Terraform Destroy') {
            steps {
                sh 'terraform destroy -var-file=./vars/dev.tfvars -auto-approve'
            }
        }
    }
}
