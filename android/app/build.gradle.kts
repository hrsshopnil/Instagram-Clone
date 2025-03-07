plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
}

android {
    namespace = "com.shopnilhasan.instagram_clone"
    compileSdk = 34 // Manually set compileSdkVersion
    ndkVersion = "27.0.12077973" // Use correct NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.instagram_clone"
        minSdk = 23 // Updated from 21 to match Firebase requirements
        targetSdk = 34 // Set target SDK manually
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // Remove signingConfig if you're not using custom signing for release builds
        }
        debug {
            isDebuggable = true
        }
    }

    lint {
        disable += "InvalidPackage"
        checkReleaseBuilds = false
    }
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
    implementation(platform("com.google.firebase:firebase-bom:32.7.4"))
    implementation("com.google.firebase:firebase-analytics-ktx")
}

flutter {
    source = "../.."
}
