# Jenkins GitHub Integration 
[*Reference*](https://plugins.jenkins.io/git/)
### Confgure GitHub Secret in Jenkins
- Generally - UserName/PWD is configured for HTTP/HTTPS protocl based git clone, SSH Private key configured for SSH based git clone.
- On any EC2 instance generate SSH keys using following ( empty passphrase )
    >  ssh-keygen -f ~/.ssh/github_creds
- Configure SSH Private Key 
    - Open Git Profile > "SSH & GPG Keys" 
