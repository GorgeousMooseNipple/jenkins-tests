pipeline {
    agent none

    stages {
        stage("Build agent image") {
            agent {
                label "master"
            }
            steps {
                script {
                    docker.build("ansible-controller", "./ansible.Dockerfile")
                }
            }
        }

        stage("Run ansible playbook") {
            agent {
                docker {
                    image "ansible-controller"
                    args "--entrypoint /bin/bash"
                }
                steps {
                    script {
                        // Debug
                        sh "pwd"
                        sh "ls -lah"

                        sh "ansible-playbook -i localhost, ./playbook.yml"
                    }
                }
            }
        }
    }
}
