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
 * @description Test the logger
 */
@isTest
private class ApexLoggerTest {

    /**
     * @brief Check message validity
     * @description [Check message validity
     */
    @isTest static void testMessages() {
        // arrange & act
        List<String> messages = ApexLoggerTest.getLogMessages();

        ILogger logger = ApexLoggerTest.getLogger(LoggingLevel.DEBUG);

        for (Integer inx = 0; inx < messages.size(); inx++) {
            logger.debug(messages[inx]);
            ApexLoggerTest.assertion(logger.lastMessage(), String.valueOf(LoggingLevel.DEBUG) + ' : ' + messages[inx]);
        }
    } // end of testMessages

    /**
     * @brief Test log level
     * @description est log level
     */
    @isTest static void testLogLevel() {
        // arrange & act
        List<LoggingLevel> loglevel = new LoggingLevel[] {
            LoggingLevel.INFO
            , LoggingLevel.DEBUG
            , LoggingLevel.ERROR
            , LoggingLevel.FINE
            , LoggingLevel.FINER
            , LoggingLevel.FINEST
        };

        ILogger logger = ApexLoggerTest.getLogger(LoggingLevel.DEBUG);

        for (Integer inx = 0; inx < loglevel.size(); inx++) {
            logger.logLevel(loglevel[inx]);
            ApexLoggerTest.assertion(String.valueOf(loglevel[inx]), String.valueOf(loglevel[inx]));
        }
    } // end of testLogLevel

    /**
     * @brief Explicit Log
     * @description Explicit Log
     */
    @isTest static void testExplicitLogLevel() {
        // arrange & act
        String message = 'message';
        ILogger logger = ApexLoggerTest.getLogger(LoggingLevel.DEBUG);

        logger.info(message);
        ApexLoggerTest.assertion(String.valueOf(LoggingLevel.INFO) + ' : ' + message, logger.lastMessage() );
        logger.warn(message);
        ApexLoggerTest.assertion( String.valueOf(LoggingLevel.WARN) + ' : ' + message, logger.lastMessage() );
        logger.debug(message);
        ApexLoggerTest.assertion( String.valueOf(LoggingLevel.DEBUG) + ' : ' + message, logger.lastMessage() );
        logger.error(message);
        ApexLoggerTest.assertion( String.valueOf(LoggingLevel.ERROR) + ' : ' + message, logger.lastMessage() );
        logger.fine(message);
        ApexLoggerTest.assertion( String.valueOf(LoggingLevel.FINE) + ' : ' + message, logger.lastMessage() );
        logger.finer(message);
        ApexLoggerTest.assertion( String.valueOf(LoggingLevel.FINER) + ' : ' + message, logger.lastMessage() );
        logger.finest(message);
        ApexLoggerTest.assertion( String.valueOf(LoggingLevel.FINEST) + ' : ' + message, logger.lastMessage() );
    } // end of testExplicitLogLevel

    /**
     * @brief test message written with proper log level
     * @description test message written with proper log level
     */
    @isTest static void testMessagesWithInjectionOfLogLevel() {
        // arrange & act
        List<String> messages = ApexLoggerTest.getLogMessages();

        ILogger logger = ApexLoggerTest.getLogger(LoggingLevel.FINEST);

        for (Integer i = 0; i < messages.size(); i++) {
            logger.write(messages[i]);
            ApexLoggerTest.assertion(logger.lastMessage(), String.valueOf(LoggingLevel.FINEST) + ' : ' + messages[i]);
        }
    } // end of testMessagesWithInjectionOfLogLevel

    /**
     * @brief test message written with improper log level
     * @description test message written with improper log level
     */
    @isTest static void negativeTestMessagesWithInjectionOfLogLevel() {
        // arrange & act
        List<String> messages = ApexLoggerTest.getLogMessages();

        ILogger logger = ApexLoggerTest.getLogger(LoggingLevel.FINEST);

        for (Integer i = 0; i < messages.size(); i++) {
            logger.write(messages[i]);
            ApexLoggerTest.assertion( logger.lastMessage(), String.valueOf(LoggingLevel.FINER) + ' : ' + messages[i], false);
        }
    } // end of negativeTestMessagesWithInjectionOfLogLevel

    /**
     * @brief make an assertion
     * @description make an assertion
     *
     * @param name lookup string
     * @param factory IApexFactory
     * @return true if the assertion was correct
     */
    private static Boolean assertion(String lhs, String rhs) {
        // assert
        return AssertsTestUtility.equals(lhs, rhs, true);
    } // end of assertion

    /**
     * @brief make an assertion
     * @description make an assertion
     *
     * @param name lookup string
     * @param factory IApexFactory
     * @param useEquals use equals comparison
     * @return true if the assertion was correct
     */
    private static Boolean assertion(String lhs, String rhs, Boolean useEquals) {
        // assert
        Boolean results = false;

        if ( useEquals ) {
            results = AssertsTestUtility.equals(lhs, rhs);
        } else {
            results = AssertsTestUtility.notEquals(lhs, rhs);
        }

        return results;
    } // end of assertion

    //
    // get the logger ... can be changed to pull from the test environment (if needed)
    private static ILogger getLogger(LoggingLevel loglevel) {
        return new ApexLogger(logLevel);
    } // end of getLogger

    //
    // get log messages
    //
    private static List<String> getLogMessages() {
        List<String> messages = new String[] {
            'info'
            , 'debug'
            , 'error'
            , 'fine'
            , 'finer'
            , 'finest'
        };
        return messages;
    } // end of getLogMessages

}