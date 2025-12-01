pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Kuete-12/MeliKueteSamuel.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Compilation du projet...'
            }
        }

        stage('Test') {
            steps {
                echo 'Exécution des tests...'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Déploiement en cours...'
            }
        }
    }
}

