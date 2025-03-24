terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.65.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "70d3ca1d-a411-4231-8ec2-eae8259a6010"
}

provider "databricks" {
  host = azurerm_databricks_workspace.dbw.workspace_url
}

resource "azurerm_resource_group" "rg" {
  name     = "data-engineering-rg"
  location = "East US"
}

resource "azurerm_storage_account" "adls" {
  name                     = "aviationdatalake"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_account_network_rules" "adls_network" {
  storage_account_id = azurerm_storage_account.adls.id
  default_action     = "Allow"
  bypass             = ["AzureServices"]
}

resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_id    = azurerm_storage_account.adls.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_id    = azurerm_storage_account.adls.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_id    = azurerm_storage_account.adls.id
  container_access_type = "private"
}

resource "azurerm_synapse_workspace" "synapse" {
  name                                 = "aviation-synapse-ws"
  resource_group_name                  = azurerm_resource_group.rg.name
  location = "East US 2"
  storage_data_lake_gen2_filesystem_id = "https://${azurerm_storage_account.adls.name}.dfs.core.windows.net/${azurerm_storage_container.bronze.name}"
  sql_administrator_login              = "adminuser"
  sql_administrator_login_password     = "SecureP@ssword123"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_synapse_firewall_rule" "allow_my_ip" {
  name                 = "allow_my_ip"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = "156.198.78.239"
  end_ip_address       = "156.198.78.239"
}

resource "azurerm_synapse_firewall_rule" "allow_dbt_ip" {
  name                 = "allow_dbt_ip"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = "3.214.191.130"  
  end_ip_address       = "3.214.191.130"
}

resource "azurerm_role_assignment" "synapse_storage_access" {
  scope                = azurerm_storage_account.adls.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_synapse_workspace.synapse.identity[0].principal_id
}

resource "azurerm_databricks_workspace" "dbw" {
  name                = "databricks-workspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"
}

resource "databricks_cluster" "databricks_cluster" {
  cluster_name                 = "databricks-single-node"
  spark_version                = "13.3.x-scala2.12"
  node_type_id                 = "Standard_D3_v2"
  num_workers                  = 0  # Set to 0 for a single-node cluster
  autotermination_minutes      = 10
  enable_elastic_disk          = true
  enable_local_disk_encryption = true
}


# resource "azurerm_role_assignment" "databricks_storage_access" {
#   scope                = azurerm_storage_account.adls.id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id = "6e2a277d-282f-4b79-a3e3-d6d27afc8394"
# }
