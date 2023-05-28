# # Use a base image
# FROM ubuntu:latest

# # Install dependencies
# RUN apt-get update

# # Install OpenJDK 11
# RUN apt-get install -y openjdk-11-jdk


# # Set up environment variables
# ENV KAFKA_HOME=/opt
# ENV PATH=${PATH}:${KAFKA_HOME}/bin

# # Download and extract Kafka
# WORKDIR /opt
# COPY . .
# # Expose Kafka and ZooKeeper ports
# EXPOSE 9092 2181
# RUN chmod +x /opt/bin/*.sh
# # Set the entry point command
# CMD ["sh", "-c", "/opt/bin/zookeeper-server-start.sh /opt/config/zookeeper.properties & sleep 10  && /opt/bin/kafka-server-start.sh /opt/config/server.properties"]


# #To build the image, you can use the following command:
# #docker build -t kafka:latest .

# #To run the image, you can use the following command:
# #docker run -p 9092:9092 -p 2181:2181 kafka:latest

# Stage 1: Build ZooKeeper image
FROM zookeeper as zookeeper

# No additional configuration required for ZooKeeper

# Stage 2: Build Kafka image
FROM confluentinc/cp-kafka

# Set environment variables for Kafka
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
ENV KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
ENV KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
ENV KAFKA_DEFAULT_REPLICATION_FACTOR=1
ENV KAFKA_DELETE_TOPIC_ENABLE=true
ENV KAFKA_LOG_RETENTION_BYTES=1073741824
ENV KAFKA_LOG_RETENTION_HOURS=168
ENV KAFKA_NUM_PARTITIONS=1
ENV KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1

# Copy custom server.properties to Kafka container
# COPY custom-server.properties /etc/kafka/server.properties

# Set the entry point command to start Kafka
CMD ["kafka-server-start"]
