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
 * @description Used for Soft / Hard Asserts
 */
public with sharing class AssertsTestUtility {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    // whether to ignore soft assertion setting and perform hard-assert
    private static Boolean noSoftAssertSettings = false;

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctors
    ////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @description Ignore soft-assert and perform hard-assert no matter the static resource setting
     *
     * @return  status of whether to ignore the soft assert
     */
    public static Boolean ignoreSoftAssert {
        get { return AssertsTestUtility.noSoftAssertSettings; }
        set { AssertsTestUtility.noSoftAssertSettings = value; }
    } // end of ignoreSoftAssert

    /**
     * @description Used for Soft Asserts Equality
     *
     * @param Object. Left-hand side
     * @param Object. Right-hand side
     * @return  true if equal; otherwise, false
     */
    public static Boolean equals(Object lhs, Object rhs) {
        return AssertsTestUtility.equals(lhs, rhs, true);
    } // end of equals

    /**
     * @brief String Equality
     * @description Are two strings equal using string.equals() method
     *
     * @param lhs left-hand-side of string
     * @param rhs right-hand-side of string
     *
     * @return  true if equal; otherwise, false
     */
    public static Boolean equals(String lhs, String rhs) {
        return AssertsTestUtility.equals(lhs, rhs, true);
    } // end of equals

    /**
     * @description Used for Soft Asserts Equality
     *
     * @param Object. Left-hand side
     * @param Object. Right-hand side
     * @param Boolean. expected results true/false
     *
     * @return  true if equal; otherwise, false
     */
    public static Boolean equals(Object lhs, Object rhs, Boolean expected) {
        String message = formatMessage(lhs, rhs, ' == ');
        Boolean status = lhs == rhs ;

        AssertsTestUtility.processRequest(lhs, rhs, status, expected, 'Soft Assert Equal', message, false);
        return status;
    } // end of equals

    /**
     * @brief String Equality
     * @description Are two strings equal using string.equals() method
     *
     * @param lhs left-hand-side of string
     * @param rhs right-hand-side of string
     * @param Boolean. expected results true/false
     *
     * @return  true if equal; otherwise, false
     */
    public static Boolean equals(String lhs, String rhs, Boolean expected) {
        String message = formatMessage(lhs, rhs, ' == ');
        Boolean status = lhs != null ? lhs.equals(rhs) : rhs != null ? rhs.equals(lhs) : true;

        AssertsTestUtility.processRequest(lhs, rhs, status, expected, 'Soft Assert Equal', message, false);
        return status;
    } // end of equals

    /**
     * @description Used for Soft Asserts InEquality
     *
     * @param Object. Left-hand side
     * @param Object. Right-hand side
     * @return  true if equal; otherwise, false
     */
    public static Boolean notEquals(Object lhs, Object rhs) {
        return AssertsTestUtility.notEquals(lhs, rhs, true);
    } // end of notEquals

    /**
     * @brief String InEquality
     * @description Are two strings not equal using !string.equals() method
     *
     * @param lhs left-hand-side of string
     * @param rhs right-hand-side of string
     *
     * @return  true if equal; otherwise, false
     */
    public static Boolean notEquals(String lhs, String rhs) {
        return AssertsTestUtility.notEquals(lhs, rhs, true);
    } // end of notEquals

    /**
     * @description Used for Soft Asserts InEquality
     *
     * @param Object. Left-hand side
     * @param Object. Right-hand side
     * @param Boolean. expected results true/false
     *
     * @return  true if equal; otherwise, false
     */
    public static Boolean notEquals(Object lhs, Object rhs, Boolean expected) {
        String message = formatMessage(lhs, rhs, ' != ');
        Boolean status = lhs != rhs ;

        AssertsTestUtility.processRequest(lhs, rhs, status, expected, 'Soft Assert Not Equal', message, true);
        return status;
    } // end of notEquals

    /**
     * @brief String InEquality
     * @description Are two strings not equal using !string.equals() method
     *
     * @param lhs left-hand-side of string
     * @param rhs right-hand-side of string
     * @param Boolean. expected results true/false
     *
     * @return  true if not equal; otherwise, false
     */
    public static Boolean notEquals(String lhs, String rhs, Boolean expected) {
        String message = formatMessage(lhs, rhs, '!=');
        Boolean status = lhs != null ? !lhs.equals(rhs) : rhs != null ? !rhs.equals(lhs) : false;

        AssertsTestUtility.processRequest(lhs, rhs, status, expected, 'Soft Assert Not Equal', message, true);
        return status;
    } // end of notEquals

    /**
     * @description Soft Asserts turned on || off
     *
     *  @return  true if soft-assert is enabled; otherwise, false
     *
     */
    public static Boolean isSoftAssert() {
        Boolean softAssertion = true;

        try {
            if ( !AssertsTestUtility.ignoreSoftAssert ) {
                String result = (String)TestEnvironmentSingleton.getInstance().provider().get(ApexTestUtilities.AttributeSoftAssert);
                softAssertion = result.equals( ApexTestUtilities.AttributeIsOn);
            } else {
                softAssertion = false;
            }
        } catch (Exception excp) {
            AssertsTestUtility.processError(excp, 'Exception in isSoftAssert :');
        }

        return softAssertion;
    } // end of isSoftAssert

    /**
     * @description is a test method enabled or not
     *
     * @param String . The method including the class name,i.e MyClass.MyTestMethod.
     *
     * @return  true if method is enabled; otherwise, false
     */
    public static Boolean isTestMethodEnabled(String method) {
        Boolean result = false;

        try {
            result = String.valueOf(TestEnvironmentSingleton.getInstance().provider().get(method)) == ApexTestUtilities.AttributeIsOn;
            String currentMethod = String.isBlank(method) ? '' : method;
            String isEnabledMsg = (result) ? ' enabled' : ' disabled' ;
            String message = 'Method (' + currentMethod + ') is ' + isEnabledMsg;

            TestEnvironmentSingleton.getInstance().logger().write('\n\n' + message );
        } catch (Exception excp) {
            AssertsTestUtility.processError(excp, 'Exception in isTestMethodEnabled :');
        }

        return result;
    } // end of isTestMethodEnabled

    ////////////////////////////////////////////////////////////////////////////////
    /// Private Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief Process the test request
     * @description Process the test request
     *
     * @param lhs left-hand-side of string
     * @param rhs right-hand-side of string
     * @param status comparison status
     * @param expected behaviour
     * @param message of test
     * @param isNotEqual  is this a not equal operator
     */
    private static void processRequest(Object lhs
            , Object rhs
            , Boolean status
            , Boolean expected
            , String displayMsg
            , String message
            , Boolean isNotEqual) {
        AssertsTestUtility.checkAndLog(status, displayMsg , message, expected);
        AssertsTestUtility.hardAssert(lhs, rhs,   expected, message, isNotEqual);
    } // end of processRequest

    /**
     * @brief check status and log
     * @description check the boolean status of the comparison and write information to the logger
     *
     * @param status Boolean operation
     * @param text String that holds the operator
     * @param message String that holds the message
     * @param Boolean expected behavior true/false
     */
    private static void checkAndLog(Boolean status, String text, String message, Boolean expected) {
        String expectedMsg = expected == status ? '[PASSED] ' : '[FAILED]';
        String textVal = text == null ? '(null)' : text;
        String msg = message == null ? '(null)' : message;

        try {
            ILogger logger = TestEnvironmentSingleton.getInstance().logger();

            if ( status) {
                logger.write('\n ' + expectedMsg + textVal + ' [TRUE ] : ' + msg);
            } else {
                logger.write('\n ' + expectedMsg + textVal + ' [FALSE] : ' + msg);
            }
        } catch (Exception excp) {
            AssertsTestUtility.processError(excp, 'Exception in AssertsTestUtility:checkAndLog [check logger]:');
        }
    } // end of validAndLog

    /**
     * @brief check to perform a hard assert
     * @description check to determine if a hard assert. Hard assert that fail cause the testing to stop
     *
     * @param lhs left-hand side of the operator
     * @param rhs right-hand side of the operator
     * @param expected behaviour
     * @param message String of the message
     * @param isNotEqual  is this a not equal operator
     */
    private static void hardAssert(Object lhs, Object rhs, Boolean expected, String message, Boolean isNotEqual) {
        //  hard assert
        if ( !AssertsTestUtility.isSoftAssert() ) {
            TestEnvironmentSingleton.getInstance().logger().write('\n++++++++ Performing AssertsTestUtility.hardAssert assertNotEquals/assertEquals [Expecting - ' +  String.valueOf( expected) + '] ++++++++' );
            Boolean objectsAreStrings = AssertsTestUtility.testForStrings(lhs, rhs, expected, message, isNotEqual);
            // assert objects
            if ( !objectsAreStrings ) {
                AssertsTestUtility.testObjectEquality(lhs, rhs, expected, message, isNotEqual);
            } // endif !objectsAreStrings
        }
    } // end of hardAssert

    /**
     * @brief test for strings
     * @description test for  strings
     *
     * @param lhs left-hand side of the operator
     * @param rhs right-hand side of the operator
     * @param expected behaviour
     * @param message String of the message
     * @param isNotEqual  is this a not equal operator
     *
     * @return true if both are strings
     */
    private static Boolean testForStrings(Object lhs, Object rhs, Boolean expected, String message, Boolean isNotEqual) {
        Boolean areStrings = lhs instanceof String && rhs instanceof String;

        if ( areStrings ) {
            String sRhs = (String)rhs;
            String sLhs = (String)lhs;
            Boolean areNull = sLhs == null && sRhs == null ;

            if ( isNotEqual ) {
                if ( areNull ) {
                    system.assert((sLhs != sRhs) == expected, '\n [FAILED - String] Hard Assert: ' + message);
                } else {
                    system.assert(!sLhs.equals(sRhs) == expected, '\n [FAILED - String] Hard Assert: ' + message);
                }
            } else {
                if ( areNull) {
                    system.assert((sLhs == sRhs) == expected, '\n [FAILED - String] Hard Assert: ' + message);
                } else {
                    system.assert(sLhs.equals(sRhs) == expected, '\n [FAILED - String] Hard Assert: ' + message);
                }
            } // endif isNotEqual
        } // endif areStrings

        return areStrings;
    } // end of areStrings

    /**
     * @brief test object equality
     * @description test object equality
     *
     * @param lhs left-hand side of the operator
     * @param rhs right-hand side of the operator
     * @param expected behaviour
     * @param message String of the message
     * @param isNotEqual  is this a not equal operator
     *
     * @return true if both are strings
     */
    private static void testObjectEquality(Object lhs, Object rhs, Boolean expected, String message, Boolean isNotEqual) {
        if ( isNotEqual ) {
            system.assert((lhs != rhs) == expected, '\n [FAILED - Object] Hard Assert: ' + message);
        } else {
            system.assert((lhs == rhs) == expected, '\n [FAILED - Object] Hard Assert: ' + message);
        } // endif isNotEqual
    } // end of testObjectEquality

    /**
     * @brief [brief description]
     * @description [long description]
     *
     * @param lhs left-hand side of the operation
     * @param rhs right-hand side of the operation
     * @param operator string operator,i.e. ==, !=
     * @return formatted string
     */
    private static String formatMessage(Object lhs, Object rhs, String operator) {
        String slhs = lhs == null ? 'null' : String.valueOf(lhs);
        String srhs = rhs == null ? 'null' : String.valueOf(rhs);

        return String.format(' [ {0} {1} {2} ]\n', new string[] { slhs, operator , srhs});
    } // end of formatMessage

    /**
     * @brief Process the error
     * @description Process the error
     *
     * @param excp Exception
     * @param message
     */
    private static void processError(Exception excp, String message) {
        ILogger logger = TestEnvironmentSingleton.getInstance().logger();
        String msg = message == null ? 'null' : message;

        if ( logger != null ) {
            logger.write(msg + excp.getMessage());
        } else {
            system.debug(msg + excp.getMessage());
            system.debug('\n\n AssertsTestUtility.processError : result from TestEnvironmentSingleton.getInstance().logger(); is NULL');
        }
    } // end of processError

} // end of AssertsTestUtility