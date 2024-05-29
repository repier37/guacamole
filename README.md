# Apache Guacamole Docker Stack

## What is Apache Guacamole?

[Apache Guacamole](https://guacamole.apache.org/) is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH. By using HTML5, Guacamole allows you to access your desktops from anywhere, without needing to install plugins or client software.

## What is this repository for?

Setting up Apache Guacamole through docker, particularly the database configuration, can be quite complicated when following the [official documentation](https://guacamole.apache.org/doc/gug/).
This repository simplifies the entire process by providing a ready-to-use Docker Compose setup. This way, you don't have to manually install and configure the database and other components.

## How to Run It

### Prerequisites

- Docker installed on your system
- Docker Compose installed on your system
- Portainer (optional, if you want to use a web-based interface)

### Running with Portainer

1. **Open Portainer:**

   Open your web browser and navigate to your Portainer instance.

2. **Create a New Stack:**

   - Go to `Stacks` in the left-hand menu.
   - Click `+ Add stack`.

3. **Configure the Stack:**

   - Name your stack, for example, `guacamole`.
   - Copy the contents of the [docker-compose.yml](https://github.com/repier37/guacamole/blob/main/docker-compose.yml) file from the GitHub repository into the `Web editor`.

4. **Add Environment Variables:**

   Under the `Environment variables` section, add the following variables with your desired values:

   ```env
   MYSQL_ROOT_PASSWORD=root_password
   MYSQL_USER=guacamole_user
   MYSQL_PASSWORD=guacamole_password
   ```

5. **Deploy the Stack:**

   - Click `Deploy the stack`.

6. **Access Guacamole:**

   Once the stack is deployed, you can access the Guacamole web interface by navigating to `http://<your-portainer-ip>:8085` in your web browser.

   The default login credentials are:

   - **Username:** guacadmin
   - **Password:** guacadmin

   **Important:** Change the default password immediately after logging in for the first time.

### Running via CLI on Linux

1. **Download the Docker Compose file:**

   ```sh
   curl -O https://raw.githubusercontent.com/repier37/guacamole/main/docker-compose.yml
   ```

2. **Create the .env file:**

   Create a `.env` file in the same directory as the `docker-compose.yml` file with the following contents:

   ```env
   MYSQL_ROOT_PASSWORD=root_password
   MYSQL_USER=guacamole_user
   MYSQL_PASSWORD=guacamole_password
   ```

   Replace the placeholder values with your desired credentials.

3. **Run Docker Compose:**

   ```sh
   docker-compose up -d
   ```

4. **Access Guacamole:**

   Once the containers are up and running, you can access the Guacamole web interface by navigating to `http://localhost:8085` in your web browser.

   The default login credentials are:

   - **Username:** guacadmin
   - **Password:** guacadmin

   **Important:** Change the default password immediately after logging in for the first time.

## More details

Basically, this docker compose use the guacamole and guacd official docker images, and a mysql 5.7 image in which the database for guacamole has been initiated. The guacamole instance will have TOTP activated.
Has the schema is modified at each version of guacamole, if you need a newer version of guacamole you need to:

## Need another version?

**Clone the repository:**

   ```sh
   git clone https://github.com/repier37/guacamole.git
   cd guacamole
  ```
- Edit Dockerfile, modify the line ```sh ARG GUAC_VERSION=1.5.5 ``` to use the version of your choosing
- From guacamole repo get the files  001-create-schema.sql and 002-create-admin-user.sql corresponding to your version (get them from [guacamole client repo](https://github.com/apache/guacamole-client/tree/main/extensions/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-mysql/schema))
- Edit the  001-initdb.sql, paste in it the content of the two previous files (create schema first, and create admin second)
- Build the image : docker build --pull --rm -f "Dockerfile" -t guacamole:latest "." 

- Edit the docker compose file to use the guacamole client and guacamole server image version of your choosing and to use the database image you just created

## How to Thank Me

If you find this repository useful, you can show your appreciation by:

- Starring the repository on GitHub
- Sharing it with others who might find it helpful
- Contributing to the project by submitting issues or pull requests
- [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate?hosted_button_id=GR74XEN538Y7L)

---

Thank you for using this Docker Compose setup for Apache Guacamole! If you have any questions or run into any issues, feel free to open an issue in the repository.

Happy remoting!
