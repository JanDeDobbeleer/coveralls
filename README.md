# coveralls

[![Build status](https://img.shields.io/appveyor/ci/janjoris/coveralls/master.svg?maxAge=2592000)](https://ci.appveyor.com/project/JanJoris/coveralls) [![Coverage Status](https://coveralls.io/repos/github/JanJoris/coveralls/badge.svg)](https://coveralls.io/github/JanJoris/coveralls) [![Gitter](https://badges.gitter.im/posh-coveralls/Lobby.svg)](https://gitter.im/posh-coveralls/Lobby) [![PS Gallery](https://img.shields.io/badge/PS%20Gallery-install-blue.svg)](https://www.powershellgallery.com/packages/coveralls)

A PowerShell module to publish code coverage to [Coveralls.io](https://coveralls.io) using Pester

## Usage

Decide which files you want to have covered (similar to the way Pester handles it).

    $files = @('Helpers\PoshGit.ps1','Helpers\Prompt.ps1','install.ps1')

You could also use Get-ChildItem with wildcards instead.

    $files = Get-ChildItem * -Include *.ps1,*.psm1

Get the infomation and publish it to Coveralls.io

    $token = 'BHJjjgRTHGgs776BGTYcdcjJT987jjGG'
    $coverage = Format-Coverage -Include $files -CoverallsApiToken $token
    Publish-Coverage -Coverage $coverage

If you run you tests outside of the root folder of your repository, you need to specify it's location so that Coveralls can find the files and display the information nicely.

    $coverage = Format-Coverage -Include $files -CoverallsApiToken $token -RootFolder ../

In case your CI does not allow you to fetch the branchname due to a checkout on a commit, you can specify it otherwise. This example uses Appveyor's environment variables.

    $coverage = Format-Coverage -Include $files -CoverallsApiToken $token -BranchName $ENV:APPVEYOR_REPO_BRANCH
