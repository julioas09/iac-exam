param storageAccountNames array = [
  'jseijasfinalexam1'
  'jseijasfinalexam2'
]
param location string = resourceGroup().location
@allowed([
  'Standard_GRS'
  'Standard_LRS'
  ])
param staSkuName string = 'Standard_LRS'
@allowed([
  'StorageV2'
  'BlobStorage'
  ])
param staKind string = 'StorageV2'


resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-09-01' = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
  location: location
  kind: staKind
  sku: {
    name: staSkuName
  }
}]
  