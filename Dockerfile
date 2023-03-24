FROM openjdk:11

LABEL jvidalg <jesus.vidal.go@gmail.com>

ENV ANDROID_SDK_URL https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
ENV ANDROID_API_LEVEL android-30
ENV ANDROID_BUILD_TOOLS_VERSION 30.0.3
ENV ANDROID_HOME /usr/lib/android-sdk
ENV ANDROID_VERSION 30
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/bin

# Download Android SDK
RUN apt update -y && \
    apt install android-sdk -y


RUN mkdir .android && \
    cd "$ANDROID_HOME" && \
    curl -o sdk.zip $ANDROID_SDK_URL && \
    unzip sdk.zip && \
    rm sdk.zip && \
# Install Fastlane
    apt-get update && \
    apt-get install --no-install-recommends -y --allow-unauthenticated build-essential git ruby-full && \
    gem install rake && \
    gem install fastlane && \
    gem install bundler && \
    bundle update --bundler && \
# Clean up
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
apt-get autoremove -y && \
apt-get clean
