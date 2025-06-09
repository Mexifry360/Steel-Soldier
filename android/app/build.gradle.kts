plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ Add this for Firebase
}

android {
    namespace = "com.mexifry360.steel_soldier"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.mexifry360.steel_soldier"
        minSdk = 23 // 🔧 Updated to match biometric_storage minimum
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    isCoreLibraryDesugaringEnabled = true // ✅ Add this line
}

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:33.15.0"))

    // ✅ Firebase SDKs (add/remove as needed)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")

    // ✅ Java 8+ support
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

