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

        stage('Terraform Deploy') {
            steps {
                script {
                        if (params.action == 'apply') {
                            sh '''
                                export TF_INPUT=false

                                terraform init -reconfigure
                                terraform workspace select dev || terraform workspace new dev
                                terraform plan -var-file=./vars/dev.tfvars -out=tfplan
                                terraform apply -input=false tfplan
                        '''
                    } else if (params.action == 'destroy') {
                            sh '''
                                export TF_INPUT=false

                                terraform init -reconfigure
                                terraform workspace select dev || terraform workspace new dev
                                terraform destroy -var-file=./vars/dev.tfvars -auto-approve
                            '''
                    } else {
                            error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                }
            }
        }
    }
}
