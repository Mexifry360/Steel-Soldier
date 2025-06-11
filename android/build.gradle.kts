import org.gradle.api.tasks.Delete
import org.gradle.kotlin.dsl.*

plugins {
    // ✅ Applies Google Services plugin, but not globally enabled yet
    id("com.google.gms.google-services") version "4.4.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 🧹 Optional: relocate build directories for better project structure
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    layout.buildDirectory.set(newBuildDir.dir(name))
    evaluationDependsOn(":app")
}

// 🧼 Clean task to delete custom build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
