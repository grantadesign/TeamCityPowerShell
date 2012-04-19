<#
.SYNOPSIS
    A PowerShell Module for interacting with TeamCity
.DESCRIPTION
    
.NOTES
    File Name  : TeamCity
	Author     : Howard van Rooijen
	Requires   : PowerShell v2
.LINK
.EXAMPLE
    
    To Import the Module to the current PowerShell session:    
    > Import-Module TeamCity.psm1 -pass | fl
   
    To Remove the Module from the current PowerShell session:
    > Remove-Module TeamCity
#>

Function Get-AllAgents
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllAgents()
}

Function Get-AllBuildConfigs
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllBuildConfigs()
}

Function Get-BuildConfigByConfigurationName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByConfigurationName($BuildConfigName)
}

Function Get-AllBuildsOfStatusSinceDate
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[DateTime]
		$Date, 
		
		[string]
		$BuildStatus
	)
	
	$client = New-TeamCityConnection @PSBoundParameters
	
	$statusEnum = [Enum]::Parse([TeamCitySharp.Locators.BuildStatus], $BuildStatus, $true)

    return $client.AllBuildsOfStatusSinceDate($Date, $statusEnum)
}

Function Get-AllBuildsSinceDate
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[DateTime]
		$Date
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllBuildsSinceDate($Date)
}

Function Get-AllChanges
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllChanges()
}

Function Get-AllGroupsByUserName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$UserName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllGroupsByUserName($UserName)
}

Function Get-AllProjects
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllProjects()
}

Function Get-AllRolesByUserName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$UserName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllRolesByUserName($UserName)
}

Function Get-AllServerPlugins
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllServerPlugins()
}

Function Get-AllUserGroups
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllUserGroups()
}

Function Get-AllUserRolesByUserGroup
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$UserGroupName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllUserRolesByUserGroup($UserGroupName)
}

Function Get-AllUsers
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllUsers()
}

Function Get-AllUsersByUserGroup
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$UserGroupName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllUsersByUserGroup($UserGroupName)
}

Function Get-AllVcsRoots
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllVcsRoots()
}

Function Get-AllBuildConfigs
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllBuildConfigs()
}

Function Get-AllBuildsSinceDate
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[DateTime]
		$Date
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.AllBuildsSinceDate($Date)
}

Function Get-ArtifactsByBuildId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildId,
		
		[string]
		$SavePath
	)
	
	$baseUrl = New-TeamCityUrl @PSBoundParameters
	$auth = @{$true = "/guestAuth"; $false = "/httpAuth"}[$connectionDetails.IsGuest]
	$url = $baseUrl + $auth + ("/downloadArtifacts.html?buildId={0}" -f $BuildId)
	
	$connection = New-TeamCityWebClientConnection @PSBoundParameters
	
	$connection.DownloadFile($url, $SavePath)
}

Function Get-ArtifactByBuildNumber
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId,
		
		[string]
		$BuildNumber,
		
		[string]
		$ArtifactName,
		
		[string]
		$SavePath
	)
	
	$baseUrl = New-TeamCityUrl @PSBoundParameters
	$auth = @{$true = "/guestAuth"; $false = "/httpAuth"}[$connectionDetails.IsGuest]
	$url = $baseUrl + $auth + ("/repository/download/{0}/{1}/{2}" -f $BuildConfigId, $BuildNumber, $ArtifactName)
	
	$connection = New-TeamCityWebClientConnection @PSBoundParameters
	
	$connection.DownloadFile($url, $SavePath)
}

Function Get-Artifact
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId,
		
		[string]
		$BuildId,
		
		[string]
		$ArtifactName,
		
		[string]
		$SavePath
	)
	
	$baseUrl = New-TeamCityUrl @PSBoundParameters
	$auth = @{$true = "/guestAuth"; $false = "/httpAuth"}[$connectionDetails.IsGuest]
	$url = $baseUrl + $auth + "/repository/download/{0}/{1}:id/{2}" -f $BuildConfigId, $BuildId, $ArtifactName
	
	$connection = New-TeamCityWebClientConnection @PSBoundParameters
	$connection.DownloadFile($url, $SavePath)
}

Function Get-LatestArtifact
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId,
			
		[string]
		$ArtifactName,
		
		[string]
		$SavePath
	)
	
	$baseUrl = New-TeamCityUrl @PSBoundParameters
	$auth = @{$true = "/guestAuth"; $false = "/httpAuth"}[$connectionDetails.IsGuest]
	$url = $baseUrl + $auth + "/repository/download/{0}/.lastFinished/{1}" -f $BuildConfigId, $ArtifactName
	
	$connection = New-TeamCityWebClientConnection @PSBoundParameters
	$connection.DownloadFile($url, $SavePath)
}

Function Get-ArtifactsAsArchive
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId,
		
		[string]
		$BuildId,
	
		[string]
		$SavePath
	)
	
	$baseUrl = New-TeamCityUrl @PSBoundParameters
	$auth = @{$true = "/guestAuth"; $false = "/httpAuth"}[$connectionDetails.IsGuest]
	$url = $baseUrl + $auth + "/repository/downloadAll/{0}/{1}:id" -f $BuildConfigId, $BuildId
	
	$connection = New-TeamCityWebClientConnection @PSBoundParameters
	$connection.DownloadFile($url, $SavePath)
}

Function Get-BuildConfigByConfigurationId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByConfigurationId($BuildConfigId)
}

Function Get-BuildConfigByConfigurationName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByConfigurationName($BuildConfigName)
}

Function Get-BuildConfigByProjectIdAndConfigurationId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectId,
		
		[string]
		$BuildConfigId		
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByProjectIdAndConfigurationId($ProjectId, $BuildConfigId)
}

Function Get-BuildConfigByProjectIdAndConfigurationName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectId,
		
		[string]
		$BuildConfigName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByProjectIdAndConfigurationName($ProjectId, $BuildConfigName)
}

Function Get-BuildConfigByProjectNameAndConfigurationId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectName,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByProjectNameAndConfigurationId($ProjectName, $BuildConfigId)
}

Function Get-BuildConfigByProjectNameAndConfigurationName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectName,
		
		[string]
		$BuildConfigName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigByProjectNameAndConfigurationName($ProjectName, $BuildConfigName)
}

Function Get-BuildConfigsByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigsByBuildConfigId($BuildConfigId)
}

Function Get-BuildConfigsByConfigIdAndTag
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId,
		
		[string]
		$Tag
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigsByConfigIdAndTag($BuildConfigId, $Tag)
}

Function Get-BuildConfigsByConfigIdAndTags
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId,
		
		[string[]]
		$Tags
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigsByConfigIdAndTag($BuildConfigId, $Tags)
}

Function Get-BuildConfigsByProjectId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigsByProjectId($ProjectId)
}

Function Get-BuildConfigsByProjectName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildConfigsByProjectName($ProjectName)
}

Function Get-BuildsByBuildLocator
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildsByBuildLocator()
}

Function Get-BuildsByUserName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$UserName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.BuildsByUserName($UserName)
}

Function Get-ChangeDetailsByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.ChangeDetailsByBuildConfigId($BuildConfigId)
}

Function Get-ChangeDetailsByChangeId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$Id
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.ChangeDetailsByChangeId($Id)
}

Function Get-ErrorBuildsByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.ErrorBuildsByBuildConfigId($BuildConfigId)
}

Function Get-FailedBuildsByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.FailedBuildsByBuildConfigId($BuildConfigId)
}

Function Get-LastBuildByAgent
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$AgentName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.LastBuildByAgent($AgentName)
}

Function Get-LastBuildByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.LastBuildByBuildConfigId($BuildConfigId)
}

Function Get-LastChangeDetailByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.LastChangeDetailByBuildConfigId($BuildConfigId)
}

Function Get-LastErrorBuildByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.LastErrorBuildByBuildConfigId($BuildConfigId)
}

Function Get-LastFailedBuildByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.LastFailedBuildByBuildConfigId($BuildConfigId)
}

Function Get-LastSuccessfulBuildByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.LastSuccessfulBuildByBuildConfigId($BuildConfigId)
}

Function Get-NonSuccessfulBuildsForUser
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$UserName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.NonSuccessfulBuildsForUser($UserName)
}

Function Get-ProjectById
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectLocatorId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.ProjectById($ProjectLocatorId)
}

Function Get-ProjectByName
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$ProjectLocatorName
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.ProjectByName($ProjectLocatorName)
}

Function Get-ServerInfo
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.ServerInfo()
}

Function Get-SuccessfulBuildsByBuildConfigId
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$BuildConfigId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.SuccessfulBuildsByBuildConfigId($BuildConfigId)
}

Function Get-VcsRootById
{
	param
	(
		[Hashtable]
		$ConnectionDetails,
		
		[string]
		$VcsRootId
	)
	
	$client = New-TeamCityConnection @PSBoundParameters

    return $client.VcsRootById($VcsRootId)
}

Function New-TeamCityConnection
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	$client = New-Object TeamCitySharp.TeamCityClient($ConnectionDetails.ServerUrl, $ConnectionDetails.UseSsl)
	
	$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ConnectionDetails.Credential.Password))

	$userName = $ConnectionDetails.Credential.UserName
	
	if ($userName.StartsWith("\"))
	{
		$userName = $userName.TrimStart("\")
	}

    $client.Connect($userName, $password, $ConnectionDetails.IsGuest)
	
	return $client
}

Function New-TeamCityWebClientConnection
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
		
	if ($ConnectionDetails.IsGuest)
	{
		$client = New-UnAuthenticatedWebClient
	}
	else
	{
		$client = New-AuthenticatedWebClient @PSBoundParameters
	}
	
	return $client
}

Function New-TeamCityUrl
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
	
	if ($ConnectionDetails.UseSsl)
	{
		$protocol = "https://"
	}
	else
	{
		$protocol = "http://"
	}
	
	$url = ("{0}{1}" -f $protocol, $ConnectionDetails.ServerUrl)
	
	return $url
}

Function New-AuthenticatedWebClient
{
	param
	(
		[Hashtable]
		$ConnectionDetails
	)
		
	$webclient = new-object System.Net.WebClient
	
	$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ConnectionDetails.Credential.Password))
	
	$userName = $ConnectionDetails.Credential.UserName
	
	if ($userName.StartsWith("\"))
	{
		$userName = $userName.TrimStart("\")
	}
	
	$webclient.Credentials = new-object System.Net.NetworkCredential($userName, $password)
	
	return $webclient
}

Function New-UnAuthenticatedWebClient
{
	return new-object System.Net.WebClient
}