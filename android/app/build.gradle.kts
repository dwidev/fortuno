plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.fortuno.pos"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.fortuno.pos"

        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("uat") {
            storeFile = file("keystore/uat.jks")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }
        
        // TODO(dev) : change to keystore for the play store
        create("prod") {
            storeFile = file("keystore/uat.jks")
        }
    }

    flavorDimensions += "app"

    productFlavors {
        create("uat") {
            dimension = "app"
            applicationIdSuffix = ".uat"
            resValue(
                type = "string",
                name = "appName",
                value = "Fortuno POS UAT"
            )
            signingConfig = signingConfigs.getByName("uat")
        }
        create("prod")  {
            dimension = "app"
            resValue(
                type = "string",
                name = "appName",
                value = "Fortuno POS"
            )
            signingConfig = signingConfigs.getByName("prod")
        }
    }
}

flutter {
    source = "../.."
}
