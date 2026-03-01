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
*
* 2. PLAYBOOK
*    - Type: String
*    - Required: yes
*    - Default: "./ansible/playbook.yml"
*    - Description: "Path to ansible playbook inside repository. This playbook will be executed."
*
* 3. EXTRA_VARS
*    - Type: String
*    - Required: no
*    - Description: "This string will be passed as `--extra-vars` argument to ansible playbook.
*/

pipeline {
    agent {
        label "controller"
    }

    stages {

        stage("Validate params") {
            steps {
                script {
                    sh """
                        set +x
                        echo 'Checked out ${params.TARGET_BRANCH}'
                        echo 'Will run playbook ${params.PLAYBOOK}'
                        echo 'With extra vars: ${params.EXTRA_VARS}'
                    """
                    if (params.EXTRA_VARS) {
                        sh "echo 'Replacing all double quotes in EXTRA_VARS to single quotes'"
                        env.EXTRA_VARS = env.EXTRA_VARS.replaceAll("\"", "'")
                    }
                }
            }
        }

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

                    def command = "ansible-playbook -v"
                    if (env.EXTRA_VARS) {
                        command = "${command} --extra-vars \"${env.EXTRA_VARS}\""
                    }
                    command = "${command} ${params.PLAYBOOK}"
                    sh "${command}"
                }
            }
        }
    }
}
