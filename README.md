Red5 Pro iOS Application
===
> This Xcode project shows how to integrate the [Red5 Pro](http://red5pro.com) SDKs to enable live streaming and second screen experiences on a mobile device

Quickstart
---

### If XCode not installed
1. Download the [XCode](https://itunes.apple.com/us/app/xcode/id497799835)
2. If not installed along with XCode, install XCode Command line tools:

```
$ xcode-select --install
```

### If Apple Developer Account not created
1. Create a developer account at [developer.apple.com](http://developer.apple.com)
2. Setup certificate and provisioning files. [more info](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/MaintainingCertificates/MaintainingCertificates.html)
3. Download developer certificate and place in our `Keychain`
4. While in your [developer.apple.com](http://developer.apple.com) account page, take note of the name associated with your `Development` Provisioning Profile

### Generate IPA
Replace `YOUR-PROFILE-NAME-HERE` in the following command with the name of your Development Provisioning Profile:
```
$ PROFILE_NAME=YOUR-PROFILE-NAME-HERE ./dist.sh
```

If all goes well, you will be prompted to allow codesign to use your key:

![codesign asks for access to keychain](http://infrared5.github.io/red5pro-ios-app/images/ios-setup-1.png)

Select `Allow` or `Allow Always` and the build tool should finish up shortly with the IPA available at: **dist/Red5Pro.ipa**.

### Launch on Device
1. Open iTunes
2. Plug in an iPhone or iPad and wait for sync to finish
3. Drag the generated **Red5Pro.ipa** from the previous step into iTunes
4. Navigate to the `Apps` section within iTunes and locate **Red5Pro**
5. Click `Install`
6. Click `Apply` or `Sync`

