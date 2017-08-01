/****************************************
 * Class Name  : ErrorLogClass
 *
 * Description : This class will log errors into the Error object
 *
 * Created By  : Sugandha Atrey

 * Modified By : BJA
 * @group Common Layer
 * ****************************************/
public class ErrorLogClass {

    /***************************************************************************************************
    * Method name  : logError
    * Description  : Used for creating log error.
    * Return Type  : String
    * Parameter    : Class name,Error message,method Name
    *************************************************************************************************/
    public static string logError(String ClassName, Exception errror, String methodName) {
        // Error log method
        return ErrorLogClass.logError(ClassName, errror.getMessage(), methodName);
    }

    public static string logError(String ClassName, String errror, String methodName) {
        // Error log method
        return ErrorLogClass.logError(ClassName, errror, methodName, 'Error');
    } // end of logError

    public static string logError(String ClassName, String errror, String methodName, String ltype) {
        // Error log method
        Error_Log__c er = new Error_Log__c(Class_Name__c = ClassName , Method_Name__c = methodName, Error_Description__c = errror, Type__c = ltype);
        return ErrorLogClass.insertError(er);
    } // end of logError

    public static string logWarn(String ClassName, String warning, String methodName) {
        // Error log method
        return ErrorLogClass.logError(ClassName, warning, methodName, 'Warning');
    }

    public static string logInfo(String ClassName, String info, String methodName) {
        // Error log method
        return ErrorLogClass.logError(ClassName, info, methodName, 'Info');
    }

    public static string logDebug(String ClassName, String debugInfo, String methodName) {
      // Error log method
      return ErrorLogClass.logError(ClassName, debugInfo, methodName, 'Debug');
    }

    public static string log(LoggingLevel ltype, String message) {
        // Error log method
        String level = convertLoggingLevelToString(ltype);
        Error_Log__c er = new Error_Log__c(Class_Name__c = 'N/A' , Method_Name__c = 'N/A', Error_Description__c = message, Type__c = level);

        return ErrorLogClass.insertError(er);
    } // end of logError

    /**
     * @brief insert the message into the log
     * @details insert the message into the log
     *
     * @param record
     * @return string id of record
     */
    public static string insertError(Error_Log__c record) {
        String id = null;

        try {
            insert record;
            id = record.id;
        } catch (Exception excp) {
            System.debug(LoggingLevel.ERROR, '++++ ErrorLog.insertError.Exception:' + excp.getMessage());
            System.debug(LoggingLevel.ERROR, '++++ record: ' + record);
        }

        return id;
    } // end of insertError

    /**
     * @brief Create a error log entity
     * @description [long description]
     *
     * @param ClassName [description]
     * @param errror [description]
     * @param methodName [description]
     * @param ltype [description]
     * @return [description]
     */
    public static Error_Log__c createErrorLogEntity(String ClassName, String errror, String methodName, String ltype) {
        return new Error_Log__c(Class_Name__c = ClassName
                                , Method_Name__c = methodName
                                , Error_Description__c = errror
                                , Type__c = ltype);
    }

    public static String convertLoggingLevelToString(LoggingLevel level) {
        String result = 'Info';

        if ( level == LoggingLevel.Error ) {
            result = 'Error';
        } else if ( level == LoggingLevel.DEBUG ) {
            result = 'Debug';
        } else if ( level == LoggingLevel.WARN ) {
            result = 'Warning';
        }

        return result;
    } // end of convertLoggingLevelToString

}