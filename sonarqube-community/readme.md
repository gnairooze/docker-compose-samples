# SonarQube Community Edition with PostgreSQL

## Start containers

```bash
docker-compose up -d
```

## First time setup

Once your instance is up and running, Log in to [http://localhost:9000](http://localhost:9000) using System Administrator credentials:

- login: admin
- password: admin

You will be prompted to change the password.

## Create your first project

1. Click on "Create new project".
2. I selected local project.
3. follow up the wizard.
4. once the project created on sonar, a token will be generated, copy it.

## Install Sonar Scanner

```sh
dotnet tool install --global dotnet-sonarscanner
```

## Analyze your project

1. Navigate to your project folder.
2. Run the following command to begin analysis:

    ```sh
    dotnet sonarscanner begin /k:"sonar-project-name" /d:sonar.host.url="http://localhost:9000"  /d:sonar.token="sonar-token"
    ```

3. Build your project:

    ```sh
    dotnet build
    ```

4. Complete the analysis:

    ```sh
    dotnet sonarscanner end /d:sonar.token="sonar-token"
    ```

5. Go back to your SonarQube dashboard [http://localhost:9000](http://localhost:9000) to see the analysis results.

## Links

[Sonar Documentation](https://docs.sonarsource.com/sonarqube-community-build/try-out-sonarqube/)
