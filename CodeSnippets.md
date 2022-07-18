GroovyScript for Logging

	import com.sap.gateway.ip.core.customdev.util.Message
	import java.util.HashMap

	def Message processData(Message message) {

		def body = message.getBody(java.lang.String) as String
		def messageLog = messageLogFactory.getMessageLog(message)
		if(messageLog != null){
			messageLog.addAttachmentAsString("Incoming Message", body, "text/xml")
		}

		return message
	}

API Policy: Proxy Endpoint > Preflow > Mediation Policies > Assign Message (Incoming Request) > AddHeaderAPIKey

	<AssignMessage async="false" continueOnError="false" enabled="true" xmlns='http://www.sap.com/apimgmt'>
	    <Add>
		<Headers>
		    <Header name="apikey">YourAPIKeyGoesHere</Header>
		</Headers>
	    </Add>
	    <IgnoreUnresolvedVariables>false</IgnoreUnresolvedVariables>
	    <AssignTo createNew="false" type="request"></AssignTo>
	</AssignMessage>
