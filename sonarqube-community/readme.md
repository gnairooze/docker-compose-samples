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

1. click on "Create new project".
2. i selected local project.
3. follow up the wizard.
4. once the project created on sonar, a project token will be generated, copy it.
5. click on your profile icon ( right most corner ) and click on the Account Section. Navigate to the Security section. Please proceed to generate a SonarQube User Token. Please remember to save this token somewhere as you won't be able to see it later. it will be used with redcoffee tool to export issues to pdf file.

## Install Sonar Scanner

```sh
dotnet tool install --global dotnet-sonarscanner
```

## Analyze your project

1. Navigate to your project folder.
2. Run the following command to begin analysis:

    ```sh
    dotnet sonarscanner begin /k:"sonar-project-key" /d:sonar.host.url="http://localhost:9000"  /d:sonar.token="sonar-project-token"
    ```

3. Build your project:

    ```sh
    dotnet build
    ```

4. Complete the analysis:

    ```sh
    dotnet sonarscanner end /d:sonar.token="sonar-project-token"
    ```

5. Go back to your SonarQube dashboard [http://localhost:9000](http://localhost:9000) to see the analysis results.

6. Export issues to pdf file using [RedCoffee](https://github.com/Anubhav9/RedCoffee). if you installed redcoffee inside your project, do not forget to add `.sonarqube/` in your project `.gitignore` file.

    ```sh
    pip install redcoffee

    redcoffee generatepdf --host=http://localhost:9000 --project=sonar-project-key --path=./sonar-report.pdf --token=sonar-user-token
    ```

## Links

[Sonar Documentation](https://docs.sonarsource.com/sonarqube-community-build/try-out-sonarqube/)
