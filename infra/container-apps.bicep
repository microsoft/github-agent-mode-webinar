@description('Demo instance name for resource naming')
param demoInstanceName string

@description('Demo slug for resource naming')
param demoSlug string

@description('Location for all resources')
param location string = resourceGroup().location

@description('API container image')
param apiImage string

@description('Frontend container image')
param frontendImage string

@description('Container Apps Environment resource ID')
param containerAppsEnvironmentId string

@description('Container Registry URL')
param containerRegistryUrl string

@description('Container Registry username')
param containerRegistryUsername string

@secure()
@description('Container Registry password')
param containerRegistryPassword string

// Variables
// Removing demoSlug since Container App name length must be up to 32 characters
var cleanedName = replace(replace(replace(demoInstanceName, '${demoSlug}-', ''), '_', '-'), '--', '-')
var demoPrefix = substring(cleanedName, 0, min(length(cleanedName), 25))
var apiAppName = '${demoPrefix}-api-ca'
var frontendAppName = '${demoPrefix}-frt-ca'

// API Container App
resource apiContainerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: apiAppName
  location: location
  tags: {
    demoInstanceName: demoInstanceName
  }
  properties: {
    environmentId: containerAppsEnvironmentId
    configuration: {
      ingress: {
        external: true
        targetPort: 3000
        allowInsecure: false
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }
      secrets: [
        {
          name: 'container-registry-password-secret'
          value: containerRegistryPassword
        }
      ]
      registries: [
        {
          server: containerRegistryUrl
          username: containerRegistryUsername
          passwordSecretRef: 'container-registry-password-secret'
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'api'
          image: apiImage
          resources: {
            cpu: json('0.5')
            memory: '1Gi'
          }
          env: [
            {
              name: 'NODE_ENV'
              value: 'production'
            }
            {
              name: 'PORT'
              value: '3000'
            }
          ]
        }
      ]
    }
  }
}

// Frontend Container App
resource frontendContainerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: frontendAppName
  location: location
  tags: {
    demoInstanceName: demoInstanceName
  }
  properties: {
    environmentId: containerAppsEnvironmentId
    configuration: {
      ingress: {
        external: true
        targetPort: 80
        allowInsecure: false
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }
      secrets: [
        {
          name: 'container-registry-password-secret'
          value: containerRegistryPassword
        }
      ]
      registries: [
        {
          server: containerRegistryUrl
          username: containerRegistryUsername
          passwordSecretRef: 'container-registry-password-secret'
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'frontend'
          image: frontendImage
          resources: {
            cpu: json('0.5')
            memory: '1Gi'
          }
          env: [
            {
              name: 'API_PROTOCOL'
              value: 'https'
            }
            {
              name: 'API_HOST'
              value: apiContainerApp.properties.configuration.ingress.fqdn
            }
            {
              name: 'API_PORT'
              value: '443'
            }
          ]
        }
      ]
    }
  }
}

// Outputs
@description('API Container App FQDN')
output apiUrl string = 'https://${apiContainerApp.properties.configuration.ingress.fqdn}'

@description('Frontend Container App FQDN')
output frontendUrl string = 'https://${frontendContainerApp.properties.configuration.ingress.fqdn}'

@description('API Container App Name')
output apiAppName string = apiContainerApp.name

@description('Frontend Container App Name')
output frontendAppName string = frontendContainerApp.name
