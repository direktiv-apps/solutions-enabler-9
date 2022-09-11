
# solutions-enabler9 1.0

Run solutions-enabler9 in Direktiv

---
- #### Categories: infrastructure
- #### Image: gcr.io/direktiv/functions/solutions-enabler9 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/solutions-enabler9/issues
- #### URL: https://github.com/direktiv-apps/solutions-enabler9
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About solutions-enabler9

This function provides EMC's Solutions Enabler CLI version 9.2.3.4. The only default environment variable set is SYMCLI_OFFLINE.

It uses a `netcnfg` file in the working directory and copies it to the target location `/usr/emc/API/symapi/config/netcnfg`.  This approach means that this function can not be run in parallel with different netcnfg configurations and therefore can not  be used as namespace service or with different configurations within a workflow. 
The `netcnfg` file can be provided as workflow or namespace variable as well as direktiv file in the function payload.

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: solutions-enabler9
  image: gcr.io/direktiv/functions/solutions-enabler9:1.0
  type: knative-workflow
```
   #### Basic
```yaml
- id: solutions-enabler9
  type: action
  action:
    function: solutions-enabler9
    input: 
      files:
      - name: netcnfg
        data: SYMAPI_SERVER - TCPIP node001 12.345.67.89 7777 ANY
      commands:
      - command: symcfg -services list
      envs:
      - name: SYMCLI_OFFLINE
        value: 1
```
   #### JSON output
```yaml
- id: solutions-enabler9
  type: action
  action:
    function: solutions-enabler9
    input: 
      files:
      - name: netcnfg
        data: SYMAPI_SERVER - TCPIP node001 12.345.67.89 7777 ANY
      commands:
      - command: bash -c 'symcfg -services list -output xml_element | xq .'
```

   ### Secrets


*No secrets required*







### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
[
  {
    "result": {
      "SymCLI_ML": {
        "Network_Service": {
          "name": "SYMAPI_SERVER",
          "node_address": "12.345.67.89",
          "node_name": "node001",
          "node_port": "7777",
          "node_seclevel": "ANY",
          "pairing_method": "Single",
          "type": "TCPIP"
        }
      }
    },
    "success": true
  }
]
```

### Errors
| Type | Description
|------|---------|
| io.direktiv.command.error | Command execution failed |
| io.direktiv.output.error | Template error for output generation of the service |
| io.direktiv.ri.error | Can not create information object from request |


### Types
#### <span id="post-o-k-body"></span> postOKBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| solutions-enabler9 | [][PostOKBodySolutionsEnabler9Items](#post-o-k-body-solutions-enabler9-items)| `[]*PostOKBodySolutionsEnabler9Items` |  | |  |  |


#### <span id="post-o-k-body-solutions-enabler9-items"></span> postOKBodySolutionsEnabler9Items

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| result | [interface{}](#interface)| `interface{}` | ✓ | |  |  |
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| commands | [][PostParamsBodyCommandsItems](#post-params-body-commands-items)| `[]*PostParamsBodyCommandsItems` |  | `[{"command":"echo Hello"}]`| Array of commands. |  |
| files | [][DirektivFile](#direktiv-file)| `[]apps.DirektivFile` |  | | File to create before running commands. |  |


#### <span id="post-params-body-commands-items"></span> postParamsBodyCommandsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| command | string| `string` |  | | Command to run |  |
| continue | boolean| `bool` |  | | Stops excecution if command fails, otherwise proceeds with next command |  |
| envs | [][PostParamsBodyCommandsItemsEnvsItems](#post-params-body-commands-items-envs-items)| `[]*PostParamsBodyCommandsItemsEnvsItems` |  | | Environment variables set for each command. | `[{"name":"SYMCLI_CONNECT_TYPE","value":"REMOTE"}]` |
| print | boolean| `bool` |  | `true`| If set to false the command will not print the full command with arguments to logs. |  |
| silent | boolean| `bool` |  | | If set to false the command will not print output to logs. |  |


#### <span id="post-params-body-commands-items-envs-items"></span> postParamsBodyCommandsItemsEnvsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| name | string| `string` |  | | Name of the variable. |  |
| value | string| `string` |  | | Value of the variable. |  |

 
