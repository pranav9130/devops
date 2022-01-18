# SonarQube Server Setup

## Installation  

#### *Upgrade Java version from v8 to v11*
- Remove Older version of Java
    > yum list installed  | grep java  
    sudo yum remove -y java-1.8.0-openjdk.x86_64  
    sudo yum remove -y java-1.8.0-openjdk-devel.x86_64  
    sudo yum remove -y java-1.8.0-openjdk-headless.x86_64  
- Install openjdk 11
    > sudo yum install amazon-linux-extras  
    sudo amazon-linux-extras install -y java-openjdk11
#### *Install Postgres 11*
- Install build tools
    > sudo yum install -y readline-devel  
    sudo yum group install -y "Development Tools"
- Build the Source and Install
    > wget https://ftp.postgresql.org/pub/source/v11.0/postgresql-11.0.tar.gz  
    tar zxvf postgresql-11.0.tar.gz  
    cd postgresql-11.0  
    ./configure  
    make  
    sudo make install 
- Add following into /etc/profile for global application
    > LD_LIBRARY_PATH=/usr/local/pgsql/lib  
    export LD_LIBRARY_PATH  
    PATH=/usr/local/pgsql/bin:$PATH  
    export PATH  
    MANPATH=/usr/local/pgsql/share/man:$MANPATH  
    export MANPATH  
    PGDATA=/home/postgres/pgdata  
    export PGDATA  
- Setup Postgres Server
    > sudo adduser postgres
    sudo -u postgres -i  
    pg_ctl -D /home/postgres/pgdata -l logfile start  
- Setup Postgres Sonarqube user & schema ( in psql consoole )
    > create user sonarqube with password 'sonarqube' ;  
    ALTER USER postgres PASSWORD 'postgres';  
    create database sonarqube with owner sonarqube;
    SHOW hba_file;
- Modify Postgres Config HBA file to allow password based authentication.  
Change "trust" to md5
    > sudo vi  /home/postgres/pgdata/pg_hba.conf  
    pg_ctl stop  
    pg_ctl -D /home/postgres/pgdata -l logfile start 
#### *Install SonarQube*
[*Reference*](https://docs.sonarqube.org/latest/setup/install-server/)
- Download Source    
    > wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.2.4.50792.zip  
    unzip sonarqube-9.2.4.50792.zip  
    cd sonarqube-9.2.4.50792
- Change Virtual Mem Settings
    > sudo vi /etc/sysctl.conf  
    insert "vm.max_map_count=262144"
    sudo sysctl -p  
- Configure Postgres connection for SonarQube ( Change in conf/sonar.properties )
    > vi conf/sonar.properties and change to following  
    sonar.jdbc.username=sonarqube  
    sonar.jdbc.password=sonarqube  
    sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube  
- Configure SonarQube Web Server ( Change in conf/sonar.properties )
    > sonar.web.host=0.0.0.0  
    sonar.web.port=9000  
    sonar.web.context=  
- Start the SonarQube Server and Monitor the logs 
    > bin/linux-x86-64/sonar.sh start  
    tail -f logs/web.log

## Integration with Jenkins 
[*Reference*](https://docs.sonarqube.org/latest/analysis/jenkins/)
- Generate Auth Token in SonarQube, From SonarQube UI
    > My Account > Security > Generate Tokens 
- Generate 'jenkins_integration_token'
- Open Jenkins UI
    > Manage Jenkins > Manage Creds > Add Creds ( Global )  
- Add Secerts of kind "Secret Text" in Global Scope ( Id : sonarqube_integration_token )
- Install Sonarqube integration plugin
    > Manage Jenkins > Manage Plugins > Install "SonarQube Scanner" plugin  
    Restart Jenkins ( Happens Automatically )
- Confgure SonarQube Server on Jenkins 
    > Manage Jenkins > Configure System > SonarQube Servers  
    "Add SonarQube"  
    "Enter URL & Configure Secret text   "sonarqube_integration_token""  
    "Save"  
- Add SonarQube Scanner 
    > Manage Jenkins > Global Tool Configuration > Sonarqube Scanner > Add SonarQube scanner
- Open the Jenkins Project/Pipeline confihuration
    > Open the "build" section and add "sonarqube scanner" step
- Add sonarqube properties in "Analysis Properties" section 
    > sonar.projectKey=test-project  
    sonar.sources=src
