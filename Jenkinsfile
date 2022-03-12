def skipRemainingStages = false

pipeline {

  agent {
    node {
      label 'workstation'
    }
  }

  environment {
    TOKEN = credentials('GITHUB_TOKEN')
  }

  stages {

    stage('Check Release') {
      when {
        expression {
          GIT_BRANCH == "main"
        }
      }
      steps {
        script {
          def statusCode = sh script:"git ls-remote --tags origin | grep \$(cat VERSION | grep '^#' | head -1| sed -e 's|#|v|')", returnStatus:true
          if (statusCode == 0) {
            println "VERSION mentioned in main branch has already been tagged"
            skipRemainingStages = true
          }
        }
      }
    }

    stage('Create Release') {
      when {
        allOf {
          expression { GIT_BRANCH == "main" }
          expression { !skipRemainingStages }
        }

      }
      steps {
        script {
          def statusCode = sh script:"git ls-remote --tags origin | grep \$(cat VERSION | grep '^#' | head -1| sed -e 's|#|v|')", returnStatus:true
          if (statusCode == 0) {
            error "VERSION is already tagged, Use new version number"
          } else {
            sh '''
                mkdir temp 
                GIT_URL=$(echo $GIT_URL | sed -e "s|github.com|${TOKEN}@github.com|")
                cd temp
                git clone $GIT_URL .
                TAG=$(cat VERSION | grep "^#[0-9].[0-9].[0-9]" | head -1|sed -e "s|#|v|")
                git tag $TAG 
                git push --tags                  
              '''
          }
        }
      }
    }


    stage('Download Dependencies') {
      when {
        expression {
          !skipRemainingStages
        }
      }
      steps {
        sh '''
          npm install
        '''
      }
    }


    stage('Make Artifacts') {
      when {
        expression {
          !skipRemainingStages
        }
      }
      steps {
        sh '''
          TAG=$(cat VERSION | grep "^#[0-9].[0-9].[0-9]" | head -1|sed -e "s|#|v|")
          echo $TAG >version
          zip -r cart-${TAG}.zip node_modules server.js version
        '''
      }
    }

    stage('Publish Artifacts to Nexus') {
      when {
        expression {
          !skipRemainingStages
        }
      }
      steps {
        sh '''
          TAG=$(cat VERSION | grep "^#[0-9].[0-9].[0-9]" | head -1|sed -e "s|#|v|")
          curl -v -u admin:admin123 --upload-file cart-${TAG}.zip http://172.31.9.227:8081/repository/cart/cart-${TAG}.zip
        '''
      }
    }


  }

  post {
    always {
      cleanWs()
    }
  }

}

//
