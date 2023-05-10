# Using FastAPI Framework in an Azure Function App
Azure Functions supports WSGI and ASGI-compatible frameworks with HTTP-triggered Python functions. This can be helpful if you are familiar with a particular framework, or if you have existing code you would like to reuse to create the Function app
## Prerequisites

You can develop and deploy a function app using either Visual Studio Code or the Azure CLI. Make sure you have the required prerequisites for your preferred environment:

* [Prerequisites for VS Code](https://docs.microsoft.com/azure/azure-functions/create-first-function-vs-code-python#configure-your-environment)
* [Prerequisites for Azure CLI](https://docs.microsoft.com/azure/azure-functions/create-first-function-cli-python#configure-your-local-environment)
* Azure Deployment enviroments has provisioned the environment

## QuickStart
1. Clone this [repo](https://github.com/luxu-ms/fastapi-on-azure-functions)
2. Use VSCode to open "fastapi-on-azure-functions"
3. Right click "WrapperFunction" and select "Deploy to Function App..." (Please install exntesion "Azure Tools" if there is no such option)
4. Select the function app provisioned to deploy

## How to verify
Visit the URL https://<FunctionAppName>.azurewebsites.net/sample or  https://<FunctionAppName>.azurewebsites.net/hello/<name>


