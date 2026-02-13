import com.android.build.gradle.LibraryExtension
import com.android.build.gradle.AppExtension


allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    plugins.withId("com.android.library") {
        extensions.configure<LibraryExtension>("android") {
            if (namespace == null) {
                val manifestFile = project.file("src/main/AndroidManifest.xml")
                if (manifestFile.exists()) {
                    val packageName = Regex("package=\"([^\"]+)\"").find(manifestFile.readText())?.groups?.get(1)?.value
                    if (packageName != null) namespace = packageName
                }
                if (namespace == null) {
                    namespace = "com.daruchini.auth.${project.name.replace("-", "_").replace(":", "_")}"
                }
            }
        }
    }
    plugins.withId("com.android.application") {
        extensions.configure<AppExtension>("android") {
            if (namespace == null) {
                val manifestFile = project.file("src/main/AndroidManifest.xml")
                if (manifestFile.exists()) {
                    val packageName = Regex("package=\"([^\"]+)\"").find(manifestFile.readText())?.groups?.get(1)?.value
                    if (packageName != null) namespace = packageName
                }
                if (namespace == null) {
                    namespace = "com.daruchini.auth.${project.name.replace("-", "_").replace(":", "_")}"
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
