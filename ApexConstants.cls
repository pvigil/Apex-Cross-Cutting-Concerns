/**
 * Copyright (c) 2016, Salesforce.com, Inc.  All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 * 
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 * 
 *   * Neither the name of Salesforce.com nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
 *
 *
 * @author Salesforce
 * @date
 * @brief Apex Constants
 * @description Apex Constants
 */
public class ApexConstants {
	//
	// These names are used by the Ojbect Factory as well-known types to create
	// [the names are self-explaining]
	//
	public static final String LoggerResource = 'Logger';
	public static final String ConfigurationResource = 'Configuration';
	public static final String FallbackResource = 'FallbackResource';
	public static final String ExceptionHandler = 'ExceptionHandler';
	public static final String ExceptionFormatter = 'ExceptionFormatter';
	public static final String ExceptionPolicyHandler = 'ExceptionPolicyHandler';
	public static final String SendEmailChannel = 'SendEmailChannel';
	public static final String CacheResource = 'CacheResource';
	public static final String PreviousTransactionResultResource = 'PreviousTransactionResultResource';
	// profile name of the data migration user (this profile bypasses vr,wf,triggers, pbs and flows)
	public static final String DataWareHouseSystemAdminName = 'Data Migration System Administrator';
		/**
	 * Data Caching and DW Trigger Sections
	 *
	 * For example, to access whether data caching is enable for all call --> ApexUtilities.get(formProviderNameAccess(DataCachingCS,All_s));
	 */
	public static final String DataCachingCS = 'DataCaching';
	public static final String DataWareHouseTriggerCS = 'DataWareHouseTrigger';
	// indexes for the custom settings
	public static final String MigrationSettingName = 'MigrationSetting';
	public static final String CacheSetting = 'CacheSetting';
	public static final String TriggerSetting = 'TriggerSetting';

	public static final String MigrationRunTriggerName = 'runTrigger';
	

	// common SF object names
	public static final String ObjectName_Account = 'Account';
	public static final String ObjectName_Contact = 'Contact';
	public static final String ObjectName_Opportunity = 'Opportunity';
	public static final String ObjectName_Case = 'Case';
	public static final String ObjectName_Lead = 'Lead';
	public static final String ObjectName_Plan = 'Plan__c';
	public static final String ObjectName_Homesite = 'Homesite__c';
	public static final String ObjectName_Elevation = 'Elevation__c';
	public static final String ObjectName_DeletedRecordsSentToDWs = 'DeletedRecordsSentToDWs__c';
	public static final String ObjectName_OpportunityContactRole = 'OpportunityContactRole';
	public static final String ObjectName_BusinessUnits = 'BusinessUnits__c';
	public static final String ObjectName_Task = 'Task';

	public static final String All_s = 'All';

	/*
	 * Special values for the ESB to recognize the type of CRUD (sfdc_record_status__c)
	 */
	public static final String Create_s = 'Create';
	public static final String Update_s = 'Update';
	public static final string Delete_s = 'Delete';

	/*
	 * Misc Strings
	 */
	public static final String EmptyString = '';
	public static final String WhitespaceString = ' ';
	public static final String ORString = 'OR';
	public static final String ANDString = 'AND';
	public static final String ColonDelimiter = ':';
	public static final String Period = '.';
	public static final String CommaDelimiter = ',';
	public static final string TabDelimiter = '\t';
	public static final string NewLine = '\n';
	
} // end of ApexConstants