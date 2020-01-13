cmake_minimum_required(VERSION 3.0)
include(ScadeSDK)

add_scade_application(List_And_Tab_Practice_Scade "com.scade.List_And_Tab_Practice_Scade"
	SOURCES
	src/main.page.swift
	src/start.swift
	RESOURCES
		RESOURCES_GROUP "src" NOPREFIX
			main.page
		RESOURCES_GROUP NOBASE NOPREFIX)
set_property(TARGET List_And_Tab_Practice_Scade PROPERTY ANDROID_KEYSTORE_PROPERTIES_FILE "${ANDROID_KEYSTORE_PROPERTIES_FILE}")
set_property(TARGET List_And_Tab_Practice_Scade PROPERTY ANDROID_VERSION_NAME "1.0.0")
set_property(TARGET List_And_Tab_Practice_Scade PROPERTY ANDROID_VERSION_CODE "1")
set_property(TARGET List_And_Tab_Practice_Scade PROPERTY ANDROID_PERMISSIONS "CAMERA")
