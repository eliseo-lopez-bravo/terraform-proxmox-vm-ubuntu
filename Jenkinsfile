pipeline {
    agent any

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
                sh 'terraform plan -var-file=./vars/dev.tfvars -out tfplan'
	    }
	}
    }
}
