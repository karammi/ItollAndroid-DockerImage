# Docker file to use in android automation
FROM ubuntu:latest
   

MAINTAINER Itoll <asad.karammi@gmail.com>

ARG ANDROID_COMPILE_SDK="32"
ARG ANDROID_BUILD_TOOLS=29.0.3
ARG ANDROID_SDK_TOOLS=8512546
ARG DEBIAN_FRONTEND=noninteractive
ARG GRADLE_VERSION=7.3.3

ENV ANDROID_HOME "/android-sdk-linux"
ENV PATH "$PATH:${ANDROID_HOME}/tools:/opt/gradle/gradle-${GRADLE_VERSION}/bin"



RUN apt-get update \
        # && apt-get upgrade -y \
        && apt-get install -y git jq wget unzip curl zip openjdk-11-jdk \
        && apt-get clean

RUN wget --output-document=gradle-${GRADLE_VERSION}-all.zip https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip \
        && mkdir -p /opt/gradle \
        && unzip gradle-${GRADLE_VERSION}-all.zip -d /opt/gradle \
        && rm ./gradle-${GRADLE_VERSION}-all.zip \
        && mkdir -p ${ANDROID_HOME} \
        && wget --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip \
        && unzip ./android-sdk.zip -d ${ANDROID_HOME} \
        && rm ./android-sdk.zip \
        && mkdir -p ~/.android \
        && touch ~/.android/repository.cfg


RUN yes | ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses

# RUN ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;32.0.0" "platforms;android-32" "platform-tools"
RUN ${ANDROID_HOME}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;32.0.0"