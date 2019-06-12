Enable HTTP Strict Transport Security (HSTS) Solutions

#**********************************************
# For SharePoint 2016
#**********************************************

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

# HTTP Strict Transport Security (HSTS)
# To enable this feature on a SharePoint Web Application, 
# we can use the SharePoint Management Shell. 
# You will need to get the Web Application and then 
# set the HttpStrictTransportSecuritySettings property

$wa = Get-SPWebApplication https://contoso.com
$wa.HttpStrictTransportSecuritySettings.IsEnabled = $true
$wa.Update()

# There is also a MaxAge attribute for the HttpStrictTransportSecuritySettings property. 
# This value is 31536000 represented in seconds, by default. 
# 31536000 seconds is 365 days. 
# Consider using a value between 18 weeks (10886400) and the default value of 1 year.

$wa = Get-SPWebApplication https://sharepoint.example.com
$wa.HttpStrictTransportSecuritySettings.MaxAge = 10886400
$wa.Update()


#********************************************************************
# For SharePoint 2013 and IIS 7.0 and above with F5 to enforce HTTPS
#********************************************************************

# HTTP Strict Transport Security (HSTS) policy enables web applications to 
# enforce web browsers to restrict communication with the server over an 
# encrypted SSL/TLS connection for a set period. Policy is declared via special 
# Strict Transport Security response header. Encrypted connection protects 
# sensitive user and session data from attackers eavesdropping on network connection.

# The solution is to add a custom header in IIS to accept HSTS. 
# Open web.config of the web application and add a new custom host header 
# inside httpProtocol element.

# EXAMPLE

<system.webServer>
  <httpProtocol>
    <customHeaders>
      <add name="Strict-Transport-Security" value="max-age=31536000; includeSubDomains; preload"/>
    </customHeaders>
  </httpProtocol>
</system.webServer>

#***********************************************************************
# For SharePoint 2013 and IIS 7.0 and above with NO F5 to enforce HTTPS
#***********************************************************************

# On Microsoft systems running IIS (Internet Information Services), there are no “.htaccess” files to implement custom headers. 
# IIS applications use a central web.config file for configuration.

# For IIS 7.0 and up, the example web.config file configuration below will handle secure HTTP to HTTPS redirection 
# with HSTS enabled for HTTPS:

<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="HTTP to HTTPS redirect" stopProcessing="true">
                    <match url="(.*)" />
                    <conditions>
                        <add input="{HTTPS}" pattern="off" ignoreCase="true" />
                    </conditions>
                    <action type="Redirect" url="https://{HTTP_HOST}/{R:1}"
                        redirectType="Permanent" />
                </rule>
            </rules>
            <outboundRules>
                <rule name="Add Strict-Transport-Security when HTTPS" enabled="true">
                    <match serverVariable="RESPONSE_Strict_Transport_Security"
                        pattern=".*" />
                    <conditions>
                        <add input="{HTTPS}" pattern="on" ignoreCase="true" />
                    </conditions>
                    <action type="Rewrite" value="max-age=31536000; includeSubDomains; preload" />
                </rule>
            </outboundRules>
        </rewrite>
    </system.webServer>
</configuration>

#***********************************************************************
# For Office Web Apps and Native SQL Reporting Service that use HTTP.SYS
#***********************************************************************

# Ensure that the service is enforced for HTTPS using the F5.  No HSTS solution is available for HTTP.SYS
