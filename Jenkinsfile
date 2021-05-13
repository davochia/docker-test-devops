// Sucessful script
node {
    def app

    stage('Clone repository and Build') {
        // Get some code from a GitHub repository
        checkout scm
    }

    stage('Build maven file'){

        // Run Maven on a Unix agent.
        sh "mvn clean package"
        //archiveArtifacts 'target/*.war'
    }

    stage('Build image') {
        /* This builds the actual image */
        app = docker.build("wisekingdavid/casecourseworktest")
    }

    stage('Push image') {

        docker.withRegistry('https://registry.hub.docker.com', 'davs-dockerHub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
       echo "Trying to Push Docker Build to DockerHub"
    }

    stage('Run Docker container on Jenkins Agent') {

       sh "docker pull wisekingdavid/casecoursework"

       //sh "docker build -t wisekingdavid/casecourseworktest:latest ."
       sh "docker run -d -p 8088:8081 wisekingdavid/casecourseworktest"
    }

  stage('Run Docker container on remote hosts') {
    sh "docker run -dit -p 8088:8081 wisekingdavid/casecourseworktest"
  }

}
