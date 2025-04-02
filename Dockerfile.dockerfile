# Use an official Java runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the .war file from the host to the container
COPY target/ABCtechnologies-1.0.war /app/ABCtechnologies.war

# Expose the port that the app runs on (replace 8080 with your app's port)
EXPOSE 8080

# Run the .war file using Java
CMD ["java", "-jar", "/app/ABCtechnologies.war"]
