/*
* JOB PARAMETERS (Configured in Jenkins UI)
* =========================================
* This job relies on parameters configured in the Job configuration UI.
* Do not modify "This project is parameterized" section without updating this comment.
* 
* 1. TARGET_BRANCH
*    - Type: String
*    - Required: yes
*    - Default: "main"
*    - Description: "Wich branch to checkout?"
*/

pipeline {
    agent {
        label "controller"
    }

    stages {

        stage("Build docker agent image") {
            steps {
                script {
                    docker.build("ansible-controller:${params.TARGET_BRANCH}", "-f ./ansible.Dockerfile .")
                }
            }
        }

        stage("Run ansible playbook") {
            agent {
                docker {
                    image "ansible-controller:${params.TARGET_BRANCH}"
                }
            }
            steps {
                script {
                    // Debug
                    sh """
                        pwd
                        ls -lah
                    """

                    sh "ansible-playbook -v ./ansible/playbook.yml"
                }
            }
        }
    }
}
