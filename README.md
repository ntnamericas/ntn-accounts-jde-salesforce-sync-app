# jde-to-sf-app
jde-to-sf-app
Accounts Solution Design
 
 
Business Case 	- Simplified processes to enable data integrity
- Adopt modern strategic technology that represent our future vision and scalable solutions fit for global adoption

 
What MuleSoft Connects	MuleSoft is synchronizing the Accounts details between the Salesforce and 
JDE service.
 
Business Value Enabled	The integration effort is simplified and decoupled from QLIMS. APIs allow future experiences to be extended.


1.1 Requirements
NTN wants to create and update Accounts and sync the same in JDE Services and Salesforce.
1.	Data sync up in JDE and salesforce on any account’s creation and update.

Overall, the aim of the project is to provide seamless integration between Salesforce and JDE services/ DB.

Scope


API/ Interface Name	Approach	Source Application	Source Format	Source Protocol	Target Application	Target Format	Target Protocol
ntn-accounts-jde-salesforce-sync-app	synchronous	JDE	 	HTTPS	Salesforce	 json	HTTPS
ntn-accounts-salesforce-jde-sync-eapi	synchronous	salesforce	 XML	HTTPS	JDE	XML 	HTTPS 
ntn-accounts-sf-jde-sync-papi	synchronous						
ntn-accounts-sf-jde-sync-sapi	synchronous						

1.3 Project Dependencies
•	Salesforce Should be up and running.
•	 JDE Services and database should be up and running.
2. Solution Overview
2.1 Application Interaction Model 
 	
 


2.3 Data Flow Sequence 
1. JDE to salesforce
 
2.	Salesforce to JDE 


	
Key Discussions and Decisions
Topic 	Description 	Outcome 
Error Handling & Retry Mechanism	These APIs are real time based and response will be forwarded as is to source system	Error codes and message are sent over email to the team


3. Non-Functional Overview
3.1 Physical Interaction
The list below shows all the interfaces in scope for the project
API/Interface Name	Business Trigger	Frequency	Caching Req?	On-Prem Connectivity?	Data Classification	Business Criticality	SLA	Processing Complexity
ntn-accounts-jde-salesforce-sync-app	Schedular based	12 hours	 	 	Internal	 	 	 
ntn-accounts-salesforce-jde-sync-eapi	Real- time	 	 	 	 	 	 	 
ntn-accounts-sf-jde-sync-papi								
ntn-accounts-sf-jde-sync-sapi								

3.2 Volumetrics
API/Interface Name	Average Doc per Day	Max doc per day	Average doc per hour	Max doc per hour	Max doc per min	Avg doc size (MB)	Max doc size (MB)	1-year growth (%)	Seasonality	Working Days	Working Hours
Accounts											


3.3 Security and Access Controls
The following security mechanism are in place:
Transport Level:
•	HTTPs
Access Controls:
NA

3.4 Monitoring and Alerting
Error details are sent over email to the NTN team
3.5 High Availability, Recoverability and Replays
Error details are sent over email to the NTN team
3.6 Application Names
S.No 	Application Name 	Comments 
1	ntn-accounts-jde-salesforce-sync-app	The App collects the data from jde edwards and transforms data according to salesforce for update/create of Accounts
2	ntn-accounts-salesforce-jde-sync-eapi	This is experience API exposed to salesforce
3	ntn-accounts-sf-jde-sync-papi	This is Process API to transform the data from JDE edwards
4	ntn-accounts-sf-jde-sync-sapi	System Api that interacts with JDE Edwards 


4. Attachments
5. Review comments
6. Approval Version History
Approval Version History Is Controlled by The Solution Approval Board Only. 

