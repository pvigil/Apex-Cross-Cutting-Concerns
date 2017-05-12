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
 *
 *
 * @author Salesforce
 * @date
 * @brief Application Log
 * @description common  utilities
 * @group Common Layer
 */
public class ApplicationLog {
	//////////////////////////////////////////////////////////////////////////////////////
	// Data Members
	//////////////////////////////////////////////////////////////////////////////////////
	ApplicationLog__c entry;

	//////////////////////////////////////////////////////////////////////////////////////
	// Ctors
	//////////////////////////////////////////////////////////////////////////////////////

	/**
	 * @brief ctor
	 * @description ctor
	 */
	public ApplicationLog(ApplicationLog__c appLogEntry) {
		this.entry = appLogEntry;
	}// end of ctor
	/**
	 * @brief ctor
	 * @description ctor
	 */
	public ApplicationLog() {
		this(null, null, null, null, null);

	} // end of ctor
	/**
	 * @brief ctor
	 * @description ctor
	 */
	public ApplicationLog(String className
	                      , String methodName) {
		this(null, className, methodName, null, null);
	} // end of ctor
	/**
	 * @brief ctor
	 * @description ctor
	 */
	public ApplicationLog(Exception excp
	                      , String className
	                      , String methodName) {
		this(excp, className, methodName, null, null);

	}// end of ctor
	/**
	 * @brief ctor
	 * @description ctor
	 */
	public ApplicationLog(Exception excp
	                      , String className
	                      , String methodName
	                      , String referenceId
	                      , String referenceInfo) {
		this.entry = new ApplicationLog__c();

		this.setUserInfo();
		this.setLimitsInfo();
		this.setInvocationInfo();
		this.setExceptionInfo(excp);
		this.setSourceInfo(className, methodName);
		this.setReference(referenceId, referenceInfo);
	} // end of ctor
	//////////////////////////////////////////////////////////////////////////////////////
	// Public Methods
	//////////////////////////////////////////////////////////////////////////////////////

	public void setIntegrationPayload(String payload) {
		entry.IntegrationPayload__c = payload;
	} // end of setIntegrationPayload

	public void setReference(String referenceId, String referenceInfo) {
		entry.ReferenceId__c = referenceId;
		entry.ReferenceInfo__c = referenceInfo;
	} // end of setReference

	public Boolean save() {
		Boolean result = true;
		try {
			if ( Limits.getDMLStatements() < Limits.getLimitDMLStatements() ) {
				Database.insert(entry, false);
			}
		} catch (DMLException dmlExcp) {
			System.debug(LoggingLevel.ERROR,dmlExcp.getMessage());
			result = false;
		} catch (Exception excp) {
			result = false;
		}
		return result;
	} // end of save

	//////////////////////////////////////////////////////////////////////////////////////
	// Private Methods
	//////////////////////////////////////////////////////////////////////////////////////
	private void setSourceInfo(String className, String methodName) {
		entry.Source__c = className == null ? ApexConstants.EmptyString : className;
		entry.SourceFunction__c = methodName == null ? ApexConstants.EmptyString : methodName;
	} // end of setSourceInfo
	/**
	 * @brief set the exception information
	 * @description
	 *
	 * @param excp Exception
	 */
	private void setExceptionInfo(Exception excp) {
		if (excp != null) {
			entry.Exception__c = String.valueof(excp.getTypeName());
			entry.LogCode__c = excp.getTypeName();
			entry.Message__c = excp.getMessage();
			entry.StackTrace__c = excp.getStackTraceString();
		}
	} // end of setExceptionInfo
	/**
	 * @brief set the invocation type
	 * @description set the invocation type
	 */
	private void setInvocationInfo() {
		entry.InvocationType__c = 'Is Batch? ' + System.isBatch()
		                          + ' Is Scheduled? ' + System.isScheduled()
		                          + ' Is Future? ' + System.isFuture()
		                          + ' Is Queueable? ' + System.isQueueable()
		                          + ' Is Page? ' + System.currentPageReference();
	} // end of setInvocationInfo

	/**
	 * @brief set the limits
	 * @description set the limits
	 */
	private void setLimitsInfo() {
		String formatted = 'AggregateQueries {0}\n, Callouts {1}\n, CpuTime {2}\n, DMLRows {3}\n, DML Statements {4}\n, HeapSize {5}\n,Queries {6}\n';
		List<String> data = new String[] {
		    String.valueof(Limits.getAggregateQueries())
		    , String.valueof(Limits.getCallouts())
		    , String.valueof(Limits.getCpuTime())
		    , String.valueof(Limits.getDMLRows())
		    , String.valueof(Limits.getDMLStatements())
		    , String.valueof(Limits.getHeapSize())
		    , String.valueof(Limits.getQueries())
		};

		entry.Statistics__c = string.format(formatted, data);
	} // end of setLimitsInfo
	/**
	 * @brief set user and profile information
	 * @description  set user and profile information
	 */
	private void setUserInfo() {
		entry.Username__c = UserInfo.getUserName();
		entry.profileId__c = UserInfo.getProfileId();
		entry.UserRoleId__c = UserInfo.getUserRoleId();
	} // end of setUserInfo

} // end of ApplicationLog