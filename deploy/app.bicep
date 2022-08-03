param location string
param appServiceAppName string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'myplan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'S1'

resource myAppServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: myAppServicePlan.id
    httpsOnly: true
  }
}
