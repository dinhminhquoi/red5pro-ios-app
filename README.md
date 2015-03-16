Red5 Pro iOS Application
===
> This Xcode project shows how to integrate the [Red5 Pro](http://red5pro.com) SDKs to enable live streaming and second screen experiences on a mobile device

Quickstart
---

[&gt; Using XCode](#building-with-xcode)

[&gt; Using Command Line](#building-with-command-line)

```
$ git clone https://github.com/infrared5/red5pro-ios-app.git
$ cd red5pro-ios-app
$ xcode-select --install
$ PROFILE_NAME="YOUR-PROFILE-NAME-HERE" ./dist.sh
```

_Replace `YOUR-PROFILE-NAME-HERE` in the following command with the name of your Development Provisioning Profile_

The IPA will be generated and available at: **dist/Red5Pro.ipa**.

Requirements
---

* [Red5 Pro Server](http://red5pro.com)
* [XCode and XCode Command line tools](https://itunes.apple.com/us/app/xcode/id497799835)
* [Apple Developer Account](http://developer.apple.com)

The Red5 Pro SDKs have a minimum support for **iOS 6**.

_It is assumed you have some familiarity with generating certificates and provision files from your Apple Developer Account. Please consult the [online document](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ProvisioningDevelopment.html) for more information._

### Red5 Pro Server
The __Red5 Pro Server__ is build on the Open Source [Red5 Server](https://github.com/Red5/red5-server) and allows to build scalable live streaming and second screen applications.

The example application provided in this project repository integrates the Red5 Pro Native SDKs  and libraries that enable live streaming and second screen experiences. You will need to setup a Red5 Pro server - either on your local machine or remotely - in order to stream video and communicate with a second screen host.

More information about Red5 Pro, its SDKs and setup can be found in the online [Red5 Pro Documentation](http://red5pro.com/docs/).

**To register an account and start using Red5 Pro in production, visit the [Red5 Pro Accounts](https://account.red5pro.com/register)!**

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

Building with XCode
---

1. Navigate to the directory in which you cloned this repository.
2. Double-click on the Red5Pro.xcodeproj file.
3. XCode will open and generate the additional project files for your workspace.
4. Plug in a device (iPhone or iPad)
5. Select to `Run` on device
6. You may be prompted to allow for code signing.
7. Select `Allow` or `Always Allow`
8. The Red5 Pro iOS Application will be built and pushed to your device

**Happy streaming and second screening!**

_step #2: Double-click on Red5Pro.xcodeproj_

![codesign asks for access to keychain](http://infrared5.github.io/red5pro-ios-app/images/xcode-setup-1.png)

_step #3: XCode will open_

![codesign asks for access to keychain](http://infrared5.github.io/red5pro-ios-app/images/xcode-setup-2.png)

_step #6: You may be prompted to allow for code signing_

![codesign asks for access to keychain](http://infrared5.github.io/red5pro-ios-app/images/xcode-setup-3.png)

Building With Command Line
---

### Generate IPA

Replace `YOUR-PROFILE-NAME-HERE` in the following command with the name of your Development Provisioning Profile:

```
$ PROFILE_NAME="YOUR-PROFILE-NAME-HERE" ./dist.sh
```

As an example, if you had a provision file with the name *Awesome Developer Development*, then the command entry would look like: `PROFILE_NAME="Awesome Developer Development" ./dist.sh`.

_You can find the name associated with your provision file on your [developer.apple.com](http://developer.apple.com) account._

If all goes well, you will be prompted to allow codesign to use your key:

![codesign asks for access to keychain](http://infrared5.github.io/red5pro-ios-app/images/xcode-setup-3.png)

Select `Allow` or `Allow Always` and the build tool should finish up shortly with the IPA available at: **dist/Red5Pro.ipa**.

### Launch on Device
1. Open iTunes
2. Plug in an iPhone or iPad and wait for sync to finish
3. Drag the generated **Red5Pro.ipa** from the previous step into iTunes
4. Navigate to the `Apps` section within iTunes and locate **Red5Pro**
5. Click `Install`
6. Click `Apply` or `Sync`

**Happy streaming and second screening!**

