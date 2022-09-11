
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:


Scenario: get request

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{	
		"files": [
			{
				"name": "netcnfg",
				"data": "SYMAPI_SERVER - TCPIP node001 12.345.67.89 7777 ANY"
			}
		],
		"commands": [
		{
			"command": "bash -c 'symcfg -services list -output xml_element | xq .'",
			"silent": false,
			"print": true
		}
		]
	}
	"""
	When method POST
	Then status 200
	# And match $ ==
	# """
	# {
	# "solutions-enabler9": [
	# {
	# 	"result": "#notnull",
	# 	"success": true
	# }
	# ]
	# }
	# """
	