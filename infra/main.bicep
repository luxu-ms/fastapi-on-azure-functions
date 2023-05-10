@minLength(1)
@maxLength(64)
@description('Name which is used to generate a short unique hash for each resource')
param environmentName string = 'test'

@minLength(1)
@description('Primary location for all resources')
param location string = resourceGroup().location

var resourceToken = toLower(uniqueString(resourceGroup().id, location))
var tags = { 'azd-env-name': environmentName }

var prefix = '${environmentName}-${resourceToken}'
var appInsightsName = 'appi-${prefix}'
var appServicePlanName = 'plan-${prefix}'

module monitoring './core/monitor/monitoring.bicep' = {
  name: 'monitoring'
  params: {
    location: location
    tags: tags
    logAnalyticsName: 'log-${prefix}'
    applicationInsightsName: appInsightsName
    applicationInsightsDashboardName: 'dash-${prefix}'
  }
}

module storageAccount 'core/storage/storage-account.bicep' = {
  name: 'storage'
  params: {
    name: '${toLower(take(replace(prefix, '-', ''), 17))}storage'
    location: location
    tags: tags
  }
}

module appServicePlan './core/host/appserviceplan.bicep' = {
  name: 'appserviceplan'
  params: {
    name: appServicePlanName
    location: location
    tags: tags
    sku: {
      name: 'Y1'
      tier: 'Dynamic'
    }
  }
}

module functionApp 'core/host/functions.bicep' = {
  name: 'function'
  params: {
    name: 'func-${prefix}'
    location: location
    tags: union(tags, { 'azd-service-name': 'api' })
    alwaysOn: false
    appSettings: {
      PYTHON_ISOLATE_WORKER_DEPENDENCIES: 1
    }
    applicationInsightsName: appInsightsName
    appServicePlanId: appServicePlan.outputs.id
    runtimeName: 'python'
    runtimeVersion: '3.9'
    storageAccountName: storageAccount.outputs.name
  }
}
