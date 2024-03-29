# PowerShell script file to be executed as a AWS Lambda function. 
# 
# When executing in Lambda the following variables will be predefined.
#   $LambdaInput - A PSObject that contains the Lambda function input data.
#   $LambdaContext - An Amazon.Lambda.Core.ILambdaContext object that contains information about the currently running Lambda environment.
#
# The last item in the PowerShell pipeline will be returned as the result of the Lambda function.
#
# To include PowerShell modules with your Lambda function, like the AWSPowerShell.NetCore module, add a "#Requires" statement 
# indicating the module and version.

#Requires -Modules @{ModuleName='AWSPowerShell.NetCore';ModuleVersion='3.3.563.1'}

# Uncomment to send the input event to CloudWatch Logs
# Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)

<#
To publish a lambda:
$publishPSLambdaParams = @{
    Name = 'Intro'
    ScriptPath = '.\intro\intro.ps1'
    Region = 'us-west-1'
    IAMRoleArn = 'lambda_basic_execution
}

$publishPSLambdaParams = @{Name = 'Intro';ScriptPath = '.\intro\intro.ps1';Region = 'us-west-1';IAMRoleArn = 'lambda_basic_execution'}


Publish-AWSPowerShellLambda @publishPSLambdaParams
#>

Write-Host "Groovy."

