// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class NimTemplateTarget : TargetRules
{
	public NimTemplateTarget( TargetInfo Target) : base(Target)
	{
		Type = TargetType.Game;
		DefaultBuildSettings = BuildSettingsVersion.V2;
		IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_1;
		ExtraModuleNames.Add("NimTemplate");
		bOverrideBuildEnvironment = true;
        if (Target.Platform == UnrealTargetPlatform.Win64)
            AdditionalCompilerArguments = "/Zc:strictStrings-";
	}
}
