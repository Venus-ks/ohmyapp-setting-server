FROM openjdk:8-jdk 

ENV GRADLE_VERSION=5.6.4

WORKDIR /home

RUN apt update && \
    apt install -y wget unzip && \
    # 그래들 버젼 wget 으로 받아오는 부분
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle/gradle-${GRADLE_VERSION} /opt/gradle/latest && \
    rm -f /tmp/gradle-${GRADLE_VERSION}-bin.zip

ENV PATH="/opt/gradle/latest/bin:${PATH}"

