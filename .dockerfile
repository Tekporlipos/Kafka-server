# Use a base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update

# Set up environment variables
ENV KAFKA_HOME=/opt
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# Download and extract Kafka
WORKDIR /opt
COPY . .
# Expose Kafka and ZooKeeper ports
EXPOSE 9092 2181

# Set the entry point command
CMD ["sh", "-c", "/opt/bin/zookeeper-server-start.sh /opt/config/zookeeper.properties && /opt/bin/kafka-server-start.sh /opt/config/server.properties"]


#To build the image, you can use the following command:
#docker build -t kafka:latest .

#To run the image, you can use the following command:
#docker run -p 9092:9092 -p 2181:2181 kafka:latest
