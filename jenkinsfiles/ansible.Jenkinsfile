pipeline {
    agent none

    parameters {
        string(name: "TARGET_BRANCH", defaultValue: "main", description: "Which branch to checkout?")
    }

    stages {
        stage("Checkout branch") {
            agent {
                label "controller"
            }
            steps {
                script {
                    checkout([$class: "GitSCM",
                        branches: [[name: "*/${params.TARGET_BRANCH}"]]
                    ])
                    sh "git branch"
                }
            }
        }

        stage("Build docker agent image") {
            agent {
                label "controller"
            }
            steps {
                script {
                    sh "git branch"
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
                    sh "git branch"
                    sh "pwd"
                    sh "ls -lah"

                    sh "ansible-playbook -v ./ansible/playbook.yml"
                }
            }
        }
    }
}
