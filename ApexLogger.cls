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
 * @brief default logger
 * @description default logger uses the system debug, error, warn, info, etc.
 *     The default logging level is DEBUG. This is the default logger used by 'ApexRunEnvironmentSingleton'
 * @group Common Layer
 */
global virtual class ApexLogger implements ILogger {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * Last message written
     */
    private String theLastMessage = null;

    /**
     * @brief log level to use for 'write'
     * @description  log level to use for 'write'
     */
    private LoggingLevel theLevel;

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctors
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief default ctor of Apex Logger
     * @description default ctor of Apex Logger -- set the LoggingLevel to DEBUG
     *
     */
    public ApexLogger() {
        this.logLevel(LoggingLevel.DEBUG);
    } // end of ctor

    /**
     * @brief ctor of Apex Logger
     * @description ctor of Apex Logger
     *
     * @param level LoggingLevel to use for 'write'
     */
    public ApexLogger(LoggingLevel level) {
        this.logLevel(level);
    } // end of ctor

    ////////////////////////////////////////////////////////////////////////////////
    ///  Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief last written message
     * @description  last written message
     */
    public String lastMessage() {
        return this.theLastMessage;
    } // end of lastMessage

    /**
     * @brief write out message to sink based on the  log level setting
     * @description write out message to sink based on the  log level setting
     *
     * @param msg Object to write
     */
    public void write(Object msg) {
        this.write(this.logLevel(), msg);
    } // end of write

    /**
     * @brief info log level
     * @description info log level
     *
     * @param msg Object to write
     */
    public void info(Object msg) {
        this.write(LoggingLevel.INFO, msg);
    } // end of info

    /**
     * @brief debug log level
     * @description debug log level
     *
     * @param msg Object to write
     */
    public void debug(Object msg) {
        this.write(LoggingLevel.DEBUG, msg);
    } // end of debug

    /**
     * @brief warn log level
     * @description warn log level
     *
     * @param msg Object to write
     */
    public void warn(Object msg) {
        this.write(LoggingLevel.WARN, msg);
    } // end of warn

    /**
     * @brief error log level
     * @description error log level
     *
     * @param msg Object to write
     */
    public void error(Object msg) {
        this.write(LoggingLevel.ERROR, msg);
    } // end of error

    /**
     * @brief fine log level
     * @description fine log level
     *
     * @param msg Object to write
     */
    public void fine(Object msg) {
        this.write(LoggingLevel.FINE, msg);
    } // end of fine

    /**
     * @brief fine log level
     * @description fine log level
     *
     * @param msg Object to write
     */
    public void finer(Object msg) {
        this.write(LoggingLevel.FINER, msg);
    } // end of finer

    /**
     * @brief finest log level
     * @description finest log level
     *
     * @param msg Object to write
     */
    public void finest(Object msg) {
        this.write(LoggingLevel.FINEST, msg);
    } // end of finest

    /**
     * @brief Getter of  Loglevel
     * @description get the current logging level
     * @return LoggingLevel
     */
    public LoggingLevel logLevel() {
        return this.theLevel;
    } // end of logLevel

    /**
     * @brief Setter of  Loglevel
     * @description set the current logging level
     *
     * @param level LoggingLevel
     */
    public void logLevel(LoggingLevel level) {
        this.theLevel = level;
    } // end of logLevel

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
    protected virtual void write(LoggingLevel level, Object message) {
        // toString returns a '' value if null
        String result = ApexUtilities.toString(message);
        // remember last value
        this.setLastMessage(level, result);
        // write it
        system.debug(level, result);
    } // end of write

    /**
     * @brief Last written message
     * @description Last written message
     *
     * @param level LoggingLevel
     * @param message the message
     */
    protected virtual void setLastMessage(LoggingLevel level, String message) {
        String msg = message != null ? message : '';
        this.theLastMessage = String.format('{0} : {1}', new String[]{ String.valueOf(level), msg });
    } // end of setLastMessage

} // end of ApexLogger