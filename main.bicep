
param appServicePlanName string = 'jseijas-asp'
param appServicePlanSkuName string = 'B1'
param appServiceAppName string = 'jseijas-app'
param location string = resourceGroup().location
param storageAccountNames array = []
param deployWebApp bool = true
param mysecret string


module appService 'modules/storage.bicep' = {
  name: 'storage'
  params: { 
    location: location
    storageAccountNames: storageAccountNames
  }
}


resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = if (deployWebApp) {
name: appServiceAppName
location: location
properties: {
  serverFarmId: appServicePlan.id
  httpsOnly: true
  siteConfig: {
    appSettings: [
      {
        name: 'MYSECRET'
        value: mysecret
      }
    ]
  }
  }
}
