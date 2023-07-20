// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class NimTemplateEditorTarget : TargetRules
{
	public NimTemplateEditorTarget( TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V2;
		IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_1;
		ExtraModuleNames.Add("NimTemplate");
		bOverrideBuildEnvironment = true;
        if (Target.Platform == UnrealTargetPlatform.Win64)
            AdditionalCompilerArguments = "/Zc:strictStrings-";
    }
}
