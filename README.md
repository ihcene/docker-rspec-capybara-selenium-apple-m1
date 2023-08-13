# Rails System Specs on Apple Mac M1/M2

This project provides a demonstration of how to configure and run Rails system specs on Apple Mac using Docker and Selenium. The setup dynamically determines the right Selenium image based on the architecture of your machine (whether it's Intel or Apple Silicon) and ensures smooth operation of your Rails application.

## Requirements

- Docker
- Rails application (The context is assumed to be in the `./` directory)

## Setup

1. **Docker Script**: 
   - The script `./docker-compose` is responsible for setting the appropriate Selenium Docker image based on your machine's architecture.
   - For `arm64` architecture (Apple Silicon), it uses `seleniarm/hub:4.4.0-20220903`.
   - For Intel chips, it uses `selenium/standalone-chrome:latest`.

   Ensure that the script is executable:
   ```bash
   chmod +x ./docker-compose
   ```

2. **Docker Compose**:
   - The provided `docker-compose.yml` file sets up three main services:
     1. **web**: This represents your Rails application.
     2. **selenium-hub**: Responsible for coordinating the test sessions.
     3. **selenium-node-chrome**: The Chrome node where the tests will actually run.
     
## Running the Application and Tests

1. Start up the services:
   
   ```bash
   ./docker-compose up --build
   ```

   This command will set the appropriate Selenium image, build the Rails application Docker image and start up all services.

2. With the services up, navigate to `http://localhost:3000` in your browser to access the Rails application.

3. To run your Rails system specs:

   First, access your `web` service's terminal:
   ```bash
   docker exec web bundle exec rspec spec/system
   ```

## Environment Variables

- `SELENIUM_DRIVER_URL`: Points to the Selenium hub service.
- `CAPYBARA_APP_HOST`: Helps Capybara know where the app is running. 

## Notes

- Ensure that your Rails application's system specs are set up to use the environment variables for communicating with the Selenium server.
- If your Rails application resides in a different directory than `./`, adjust the `docker-compose.yml` file accordingly.

## Contribution

Feel free to fork this project, make improvements or adjust based on the unique needs of your setup, and submit pull requests. Feedback and contributions are always welcome!

---

Enjoy seamless Rails system spec execution on your Apple Mac!
