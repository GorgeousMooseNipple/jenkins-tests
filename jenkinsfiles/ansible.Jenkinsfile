pipeline {
    agent {
        label "controller"
    }

    parameters {
        string(name: "TARGET_BRANCH", defaultValue: "main", description: "Which branch to checkout?")
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
                    sh "pwd"
                    sh "ls -lah"

                    sh "ansible-playbook -v ./ansible/playbook.yml"
                }
            }
        }
    }
}
