# Use a base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update

# Install OpenJDK 11
RUN apt-get update && apt-get install -y openjdk-11-jdk


# Set up environment variables
ENV KAFKA_HOME=/opt
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# Download and extract Kafka
WORKDIR /opt
COPY . .
# Expose Kafka and ZooKeeper ports
EXPOSE 9092
RUN chmod +x /opt/bin/*.sh
# Set the entry point command
CMD ["sh", "-c", "/opt/bin/zookeeper-server-start.sh /opt/config/zookeeper.properties  & sleep 5 && /opt/bin/kafka-server-start.sh /opt/config/server.properties"]


#To build the image, you can use the following command:
#docker build -t kafka:latest .

#To run the image, you can use the following command:
#docker run -p 9092:9092 -p 2181:2181 kafka:latest
