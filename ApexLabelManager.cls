/**
 * Encapsulates all behaviour logic relating to the
 *
 * For more guidelines and details see
 *   https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Domain_Layer
 * @group Domain Layer
 **/
public class ApexLabelManager {

	public final static String Migrationlabel = 'lnrMigrationExclusionMessage';
	/**
	 * @brief ctor
	 * @description ctor
	 *
	 */
	public ApexLabelManager() {

	} // end of ctor

	/**
	 * @brief Get the System Label Name
	 * @details Get the System Label Name
	 *
	 * @param labelName the label name
	 * @return the value of the label in the system
	 */
	public static string getLabel(String labelName) {
		String result = null;
		try {
			// ARGH! need to find a dynamic way!
			if ( labelName == Migrationlabel ) {
				result = System.Label.lnrMigrationExclusionMessage;
			}
		} catch (Exception excp) {
			ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
		}
		return result;
	}// end of getLabel
	
	/**
	 * @brief format the label string, if the label string requires fillers
	 * @details format the label string, if the label string requires fillers
	 *
	 * @param placeholder the place holder
	 * @param valueFillers values to filler into the placeholder
	 *
	 * @return [description]
	 */
	public static string formatLabelString ( String placeholder, List<String> valueFillers) {
		String formatted = null;
		try {
			formatted = String.format(placeholder, valueFillers);
		} catch (Exception excp) {
			ApexRunEnvironmentSingleton.getInstance().exceptionHandler().process(excp);
		}
		return formatted;
	} // end of formatLabelString
} // end of ApexLabelManager