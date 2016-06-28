$u = 'watchmen'
$p = 'aKa20o01C00rdin8tor' | ConvertTo-SecureString -AsPlainText -Force
$c = New-Object System.Management.Automation.PSCredential($u, $p)



WatchmenOptions {
    # rorschach @{
    #     endpoint = 'rorschach.local'
    #     credential = $null
    # }
    notifies {
        email @{
            fromAddress = 'watchmen@mydomain.com'
            smtpserver = 'smtp.sendgrid.net'
            port =587
            subject = 'Watchmen alert - #{computername} - [#{test}] failed!'
            to = 'brandolomite@gmail.com'
            credential = $c
            usessl = $true
        }        
        eventlog @{
            eventid = '1'
            eventtype = 'error'
        }
        eventlog @{
            eventid = '10'
            eventtype = 'warning'
        }
        filesystem 'c:\temp\watchmen.log'
        slack @{
            #preText = 'Watchmen test failure'
            token = 'https://hooks.slack.com/services/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'
            author = 'Watchmen bot'
            IconUrl = 'http://codinginmysleep.com/wp-content/uploads/2012/09/WatchmenBloodySmiley-150x150.png'
            IconEmoji = ':fire:'
            channel = '#watchmen_alerts'            
        }
        syslog 'localhost'
    }
}

# This test should FAIL
WatchmenTest 'OVF.Example1' {
    #version 0.2.1
    testType 'simple'    
    #fromsource 'artifactory'
    parameters @{
        FreeSystemDriveThreshold = 50000
    }
    notifies {
        filesystem 'c:\temp\watchmen2.log'
    }
}

WatchmenTest 'OVF.Example2' {
    testType 'simple'
    test 'more services'
    # notifies {
    #     slack $false
    # }
}

# # This test should FAIL
# WatchmenTest 'MyOVFModule' {
#     version 0.1.0
#     testType 'simple'
#     test 'storage.capacity'
#     fromsource 'artifactory'
#     parameters @{
#         FreeSystemDriveThreshold = 50000
#     }
#     notifies {
#         email 'someguy@somecompany.com'
#     }
# }

# WatchmenTest 'mymodule' {
#     version 1.6.0
#     testType 'comprehensive'
#     test 'myapp.tests'
#     fromsource 'psgallery'
#     parameters @{
#         abc = 123
#     }
# }

# WatchmenOptions {
#     notifies {
#         slack @{
#             channel = '#watchmen'
#             webhook = 'https://slack.com/234902348fsdflkasdfj'
#         }
#         slack @{
#             channel = '#alerts'
#             webhook = 'https://slack.com/asdfasdfasdf'
#         }
#         slack @(
#             @{channel = '#everyone'; webhook = 'www.google.com'}
#             @{channel = '#everyone2'; webhook = 'www.google.com'}
#         )
#     }
# }

# WatchmenTest 'mymodule' {
#     version 1.6.0
#     testType 'comprehensive'
#     test 'myapp.tests'
#     fromsource 'psgallery'
#     parameters @{
#         abc = 123
#     }
# }
