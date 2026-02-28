pipeline {
    agent none

    stages {
        stage("Build agent image") {
            agent {
                label "controller"
            }
            steps {
                script {
                    docker.build("ansible-controller", "-f ./ansible.Dockerfile .")
                }
            }
        }

        stage("Run ansible playbook") {
            agent {
                docker {
                    image "ansible-controller"
                }
            }
            steps {
                script {
                    // Debug
                    sh "pwd"
                    sh "ls -lah"

                    sh "ansible-playbook -v ./ansible/playbook.yml"
                }
            }
        }
    }
}
