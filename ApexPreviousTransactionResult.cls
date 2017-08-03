/**
 * The MIT License (MIT)
 * Copyright (c) 20-April-2016 Bill J. Anderson
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
 *
 *
 * @author Salesforce
 * @date 
 * @brief Holder of the last transaction operations
 * @description Holder of the last transaction operations
 * @group Common Layer
 */
public without sharing class ApexPreviousTransactionResult implements IPreviousTransactionResult {

    /**
     * @brief last database result
     * @description last database result
     * @return Database.SaveResult
     */
    List<Database.SaveResult> lastResult;

    /**
     * @brief ctor
     * @description [long description]
     * @return [description]
     */
    public ApexPreviousTransactionResult() {
        this.databaseResult(null);
    }

    public ApexPreviousTransactionResult(List<Database.SaveResult> result) {
        this.databaseResult(result);
    }

    /**
     * @brief get last database result
     * @description et last database result
     * @return  SaveResult
     */
    public List<Database.SaveResult> databaseResult() {
        return this.lastResult;
    }

    /**
     * @brief set last database result
     * @description set last database result
     * 
     * @param result SaveResult
     */
    public void databaseResult(List<Database.SaveResult> result) {
        this.lastResult = result;
    }

} // end of ApexPreviousTransactionResult