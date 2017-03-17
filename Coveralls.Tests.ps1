$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-CoveragePercentage" {
    Context "Providing a correct return" {
        BeforeAll {
            $content = "{""created_at"":""2017-03-16T12:37:17Z"",""url"":null,""commit_message"":""Add fake data to CA_KEY when it's not present"",""branch"":""master"",""committer_name"":""Jan De Dobbeleer"",""committer_email"":""jan@gmail.com"",""commit_sha"":""ba5947862030d86208d0181189c160df04e5c309"",""repo_name"":""JanJoris/coveralls"",""badge_url"":""https://s3.amazonaws.com/assets.coveralls.io/badges/coveralls_13.svg"",""coverage_change"":0.0,""covered_percent"":%percentage%}"
        }
        It "has a coverage percentage of 13" {
            Mock Invoke-WebRequest { return @{Content = $content.Replace('%percentage%', '13') }}
            Get-CoveragePercentage -RepositoryLink coveralls | Should Be 13
        }
        It "has a coverage percentage of 28" {
            Mock Invoke-WebRequest { return @{Content = $content.Replace('%percentage%', '28') }}
            Get-CoveragePercentage -RepositoryLink coveralls | Should Be 28
        }
    }
    Context "Providing an exception return" {
        It "throws an error when providing bogus info" {
            Get-CoveragePercentage -RepositoryLink coveralls -ErrorVariable err
            $err[1].Exception.Message | Should Be 'The remote name could not be resolved: ''coveralls.json'''
        }
        It "throws an error when providing a non-existing repository" {
            Get-CoveragePercentage -RepositoryLink https://coveralls.io/coveralls/coveralls -ErrorVariable err
            $err[1].Exception.Message | Should Be 'The remote server returned an error: (404) Not Found.'
        }
    }
}
