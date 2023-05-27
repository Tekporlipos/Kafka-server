# Use a base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y default-jre wget

# Set up environment variables
ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# Download and extract Kafka
WORKDIR /opt
RUN wget https://downloads.apache.org/kafka/2.8.0/kafka_2.13-2.8.0.tgz && \
    tar -xzf kafka_2.13-2.8.0.tgz && \
    rm kafka_2.13-2.8.0.tgz && \
    mv kafka_2.13-2.8.0 kafka

# Install ZooKeeper
RUN wget https://downloads.apache.org/zookeeper/zookeeper-3.6.3/apache-zookeeper-3.6.3-bin.tar.gz && \
    tar -xzf apache-zookeeper-3.6.3-bin.tar.gz && \
    rm apache-zookeeper-3.6.3-bin.tar.gz && \
    mv apache-zookeeper-3.6.3-bin zookeeper

# Expose Kafka and ZooKeeper ports
EXPOSE 9092 2181

# Set the entry point command
CMD ["sh", "-c", "/opt/zookeeper/bin/zkServer.sh start && /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties"]


#To build the image, you can use the following command:
#docker build -t kafka:latest .

#To run the image, you can use the following command:
#docker run -p 9092:9092 -p 2181:2181 kafka:latest
