#!bin/bash
export ANDROID_HOME=~/android-sdk-linux
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
/home/alex/android-sdk-linux/tools/android sdk
/home/alex/android-sdk-linux/tools/android avd

ionic emulate android
ionic plugin add https://github.com/apache/cordova-plugin-whitelist.git

cordova plugin add ionic-plugin-keyboard

###SUPER DUPER UNSECURE CONFIG.XML
  <access origin="*" />
  <allow-intent href="*" />
  <allow-navigation href="*" />
  <access uri="*" subdomains="true" />


