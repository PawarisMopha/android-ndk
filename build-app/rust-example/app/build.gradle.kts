plugins {
    id("com.android.application")
    id("kotlin-android")
    id("org.mozilla.rust-android-gradle.rust-android")
}

android {
    namespace = "com.rust.example"
    buildToolsVersion = "35.0.0"
    ndkVersion = "29.0.14206865"
    compileSdk = 35
    
    defaultConfig {
        applicationId = "com.rust.example"
        minSdk = 21
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
        
        vectorDrawables { 
            useSupportLibrary = true
        }
    }
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }

    buildFeatures {
        viewBinding = true
    }
    
    cargo {
        prebuiltToolchains = true
        module  = "../rust"       // Or whatever directory contains your Cargo.toml
        libname = "rust"          // Or whatever matches Cargo.toml's [package] name.
        targets = listOf("arm64", "arm", "x86", "x86_64")  // See bellow for a longer list of options
    }
    
    tasks.whenTaskAdded {
        if((name == "javaPreCompileDebug" || name == "javaPreCompileRelease")) {
            dependsOn("cargoBuild")
        }
    }
    
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
    kotlinOptions.jvmTarget = "21"
}

dependencies {
    implementation("androidx.constraintlayout:constraintlayout:2.2.0")
    implementation("com.google.android.material:material:1.12.0")
    implementation("androidx.appcompat:appcompat:1.7.0")
}
