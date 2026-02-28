## Description

Test creating Jenkins pipelines, using docker containers to run ansible playbooks, creating Jenkins jobs.

## TODO:

- [x] create "ansible" job to run playbooks from docker container
- [ ] use credentials to decrypt ansible-vault
- [ ] create "build" and "autodeploy" jobs
    - [ ] make "autodeploy" triggered automatically by "build"
    - [ ] and also executable as a standalone parametrized job
