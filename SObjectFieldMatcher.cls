/**
 * Encapsulates all behaviour logic relating to the
 *
 * For more guidelines and details see
 * https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Domain_Layer
 * @group Domain Layer
 */
public class SObjectFieldMatcher implements fflib_IMatcher {

    // ---------------- Data Members ---------------------------------------

    private String toMatch;

    // ---------------- Ctors ---------------------------------------

    /**
     * @brief SObjectFieldMatcher constructor
     * @param toMatch The name to be compared
     */
    public SObjectFieldMatcher(String toMatch) {
        this.toMatch = toMatch;
    }// end of ctor

    // ---------------- Public Methods ---------------------------------------

    /**
     * @brief Match the field name based on the SObject fields
     * @details Match the field name based on the SObject fields
     *
     * @param arg field to match
     * @return Boolean true if matches ( case insensitive)
     */
    public Boolean matches(Object arg) {
        // reset the values, if any
        Boolean didMatch = false;

        if ( arg != null && arg instanceof SObject && this.toMatch != null ) {
            try {
                SObject soArg = (SObject)arg;
                Schema.DescribeSObjectResult describe = soArg.getSObjectType().getDescribe();

                for (String fieldName : describe.fields.getMap().keyset()) {
                    if ( fieldName.equalsIgnoreCase(this.toMatch) ) {
                        didMatch = true;
                        break;
                    }
                }
            } catch (Exception excp) {
                ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
            }
        }

        return didMatch;
    } // end of matches

} // end of SObjectFieldMatcher