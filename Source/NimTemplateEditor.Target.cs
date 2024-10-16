// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class NimTemplateEditorTarget : TargetRules
{
	public NimTemplateEditorTarget( TargetInfo Target) : base(Target)
	{
Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V4;

    bOverrideBuildEnvironment = true;
		if (Target.Platform == UnrealTargetPlatform.Win64) {
			AdditionalCompilerArguments = "/Zc:strictStrings-";
		}

		if (Target.Platform == UnrealTargetPlatform.Win64)
			AdditionalCompilerArguments = "/Zc:strictStrings-";
	}
}
