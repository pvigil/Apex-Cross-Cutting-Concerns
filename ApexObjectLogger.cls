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
 * @brief write to error logger
 * @description default logger uses the system debug, error, warn, info, etc. The default logging level is DEBUG. This is the default logger
 *  used by 'ApexRunEnvironmentSingleton'
 *  @group Common Layer
 *
 */
global class ApexObjectLogger extends ApexLogger {


	/**
	* @brief default ctor of ApexObject Logger
	* @description default ctor of ApexObjectLogger -- set the LoggingLevel to DEBUG
	*
	*/
	public ApexObjectLogger() {
		super(LoggingLevel.DEBUG);
	} // end of ctor
	/**
	 * @brief ctor of ApexObject Logger
	 * @description ctor of ApexObject Logger
	 *
	 * @param level LoggingLevel to use for 'write'
	 */
	public ApexObjectLogger(LoggingLevel level) {
		super(level);
	} // end of ctor


	////////////////////////////////////////////////////////////////////////////////
	/// Protected methods
	////////////////////////////////////////////////////////////////////////////////


	/**
	 * @brief write message
	 * @description write message
	 *
	 * @param level log-level
	 * @param message the message
	 */

	protected override void write(LoggingLevel level, Object message) {
		// toString returns a '' value if null
		String result = ApexUtilities.toString(message);
		// remember last value
		this.setLastMessage(level, result);
		// check limits; otherwise let parent handle it
		ApplicationLog log = new ApplicationLog(null, result);
		// save, if we can
		if ( !log.save()) {
			// let parent handle it
			super.write(level, result);
		}

	} // end of write


} // end of ApexLogger