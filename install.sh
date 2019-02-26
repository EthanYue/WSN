####DOWNLOAD JAVA 
sudo apt-get update
###download from link
http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
sudo mkdir /usr/lib/jvm
sudo tar zxvf jdk-8u91-linux-x64.tar.gz -C /usr/lib/jvm
cd /usr/lib/jvm
sudo mv jdk1.8.0_91 java


###add to .bashrc
--------------------------------
export JAVA_HOME=/usr/lib/jvm/java
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
source ~/.bashrc

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java/bin/java 300
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java/bin/javac 300
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/java/bin/jar 300
sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/java/bin/javah 300
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/java/bin/javap 300
sudo update-alternatives --config java
###test java
java -version

####DOWNLOAD OTHER TOOLS
sudo apt-get install git,curl


####DOWNLOAD ONOS
git clone https://gerrit.onosproject.org/onos
git checkout onos-sdnwise-1.10.0

####DOWNLOAD MAVEN KARAF
mkdir Application
cd Downloads
wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxvf apache-maven-3.3.9-bin.tar.gz
wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/karaf/4.2.2/apache-karaf-4.2.2.tar.gz
tar -zxvf apache-karaf-4.2.2.tar.gz

####CONFIGURATION ENV
###add to /etc/profile
--------------------------------
export ONOS_ROOT=~/onos
source $ONOS_ROOT/tools/dev/bash_profile
export PATH=${KARAF_ROOT}/bin:$PATH
MAVEN_HOME=/home/ethan/Application/apache-maven-3.6.0
export MAVEN_HOME
export PATH=${PATH}:${MAVEN_HOME}/bin
export JAVA_HOME=/usr/lib/jvm/java
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

####BUILD ONOS AND RUN MININET AND CONTIKI
source /etc/profile
source $ONOS_ROOT/tools/dev/bash_profile
$ONOS_ROOT/tools/onos-buck build onos --show-ouput
cd $ONOS_ROOT/buck-out/gen/tools/package/onos-package/
tar -zxvf onos.tar.gz
apache-karaf/bin/karaf
app activate org.onosproject.openflow
app activate org.onosproject.fwd
app activate org.onosproject.sdnwise

sudo mn --topo tree,deph=2,fanout=3 --controller=remote

cd sdn-wise-contiki/contiki/tools/cooja
sudo git submodule update --init
sudo apt-get install ant
ant run

