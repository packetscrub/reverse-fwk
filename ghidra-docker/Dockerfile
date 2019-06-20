# Ghidra build and install following
# NSA's dev guide
# https://github.com/NationalSecurityAgency/ghidra/blob/master/DevGuide.md

FROM ubuntu:18.04

RUN echo $HOME

# install dependencies
RUN apt update && apt install -y \
    gcc \
    bison \
    flex \
    flex \
    make \
    unzip \
    curl \
    wget \
    git \
    g++ \
    build-essential \
    software-properties-common

# get ghidra
RUN mkdir $HOME/git
WORKDIR $HOME/git
RUN git clone https://github.com/NationalSecurityAgency/ghidra.git

# install java openjdk 11
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get update \
	&& apt-get install -y \
		openjdk-11-jdk \ 		
	&& rm -r /var/lib/apt/lists/*

# set up gradle env
WORKDIR /tmp
RUN wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp
RUN unzip -d $HOME/gradle /tmp/gradle-*.zip
ENV GRADLE_HOME=/root/gradle/gradle-5.0
ENV PATH $GRADLE_HOME/bin:$PATH
RUN mkdir -p $HOME/.gradle/init.d/
RUN echo "\
ext.HOME = System.getProperty('user.home')\n\
\n\
allprojects {\n\
    repositories {\n\
        mavenCentral()\n\
        jcenter()\n\
        flatDir name:'flat', dirs:[\"$HOME/flatRepo\"]\n\
    }\n\
}\n\
" > $HOME/.gradle/init.d/repos.gradle

# dependencies for FileFormats
RUN mkdir $HOME/flatRepo
WORKDIR /tmp
RUN curl -OL https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip && unzip dex-tools-2.0.zip
RUN cp dex2jar-2.0/lib/dex-*.jar $HOME/flatRepo/
WORKDIR $HOME/flatRepo
RUN curl -OL https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar && mv AXMLPrinter2.jar $HOME/flatRepo/

# get DMG dependencies
WORKDIR /tmp
RUN curl -OL https://sourceforge.net/projects/catacombae/files/HFSExplorer/0.21/hfsexplorer-0_21-bin.zip
RUN mkdir hfsx
WORKDIR /tmp/hfsx
RUN unzip ../hfsexplorer-0_21-bin.zip
RUN cp lib/csframework.jar lib/hfsx_dmglib.jar lib/hfsx.jar lib/iharder-base64.jar $HOME/flatRepo/

# build ghidra
RUN mkdir -p $HOME/git/ghidra.bin/Ghidra/Features/GhidraServer/
WORKDIR $HOME/git/ghidra.bin/Ghidra/Features/GhidraServer/
RUN curl -OL https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-12.12/yajsw-stable-12.12.zip
WORKDIR $HOME/git/ghidra
RUN ls $HOME/flatRepo
RUN gradle yajswDevUnpack
RUN gradle buildGhidra

# move built zip to home
RUN mv build/dist/*.zip $HOME
WORKDIR root/
