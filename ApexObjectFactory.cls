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
 * @brief Creates  objects
 * @description Factory to create runtime objects
 * @group Common Layer
 */
public virtual with sharing class ApexObjectFactory implements IApexFactory {

    ////////////////////////////////////////////////////////////////////////////////
    /// Data Members
    ////////////////////////////////////////////////////////////////////////////////

    // the collection of object creation
    private Map<String, Type> theObjectCollection = null;

    ////////////////////////////////////////////////////////////////////////////////
    /// Ctors
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief ctor
     * @description default ctor
     */
    public ApexObjectFactory() {
        // had to use a different initialize name as I was surprised that
        // inherited (children) classes could call into my PRIVATE methods!!!!
        this.initializeBase();
    } // end of ctor

    ////////////////////////////////////////////////////////////////////////////////
    /// Public Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief create an instance by name
     * @description create an instance by name
     *
     * @param fqn fully-qualified-name, if needed
     * @return object instance
     */
    public virtual Object create(String fqn) {
        Type tfqn = Type.forName(fqn);

        return this.createFromType(tfqn, fqn);
    } // end of create

    /**
     * @brief create an object based on the namespace and name
     * @description create an object based on the namespace and name
     *
     * @param namespace the namespace of the class/type
     * @param name the name of the class/type
     *
     * @return object instance
     */
    public virtual Object create(String namespace, String name) {
        Type tfqn = Type.forName(namespace, name);

        return this.createFromType(tfqn, name);
    } // end of create

    /**
     * @brief create an object based on the type
     * @description create an object based on the type
     *
     * @param objType Type of the object
     * @return the object -- must be cast accordingly
     */
    public virtual Object create(Type objType) {
        return this.createFromType(objType, null);
    } // end of create

    /**
     * @brief associate 'name' to object type for creation
     * @description associate 'name' to object type for creation
     *
     * @param name. name used to reference type
     * @param objType. type to create
     */
    public virtual void add(String name, Type objType) {
        this.addToCollection(name, objType);
    } // end of add

    /**
     * @brief Add a type by name
     * @description Add a type by name; if match, overwrite
     *
     * @param fqn fully-qualified-name
     */
    public virtual void add(String fqn) {
        Type objType = this.findTypeByName(fqn);

        this.addToCollection(fqn, objType);
    } // end of add

    /**
     * @brief keys in the collection of creators
     * @description keys in the collection of creators
     * @return collection of string of keys Set<String>
     */
    public virtual Set<String> keys() {
        return this.theObjectCollection.keySet();
    } // end of keys

    ////////////////////////////////////////////////////////////////////////////////
    /// Protected Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief add look up and type to the known classes we create
     * @description add look up and type to the known classes we create
     *
     * @param name Name used to invoke the creator
     * @param classType class type -- what we are creating
     */
    protected virtual void addToCollection(String name, Type classType) {
        // valid data
        if ( name != null && classType != null ) {
            // create the collection, if not already present
            if ( this.theObjectCollection == null ) {
                this.theObjectCollection = new Map<String, Type>();
            }

            this.theObjectCollection.put(name, classType);
        }
    } // end of addToCollection

    ////////////////////////////////////////////////////////////////////////////////
    /// Protected Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief find the type by name
     * @description find the type by name (Fully-Qualified-Name or within the local namespace)
     *
     * @param name Fully-Qualified-Name
     * @return object type
     */
    protected virtual Type findTypeByName(String name) {
        Type objType = null;

        if ( name != null ) {
            objType = Type.forName(name);
            if ( objType == null ) {
                objType = Type.forName('', name);
            }
        }

        return objType;
    } // end of findTypeByName

    /**
     * @brief create type from name
     * @description  create the type by name (Fully-Qualified-Name or within the local namespace)
     *
     * @param foundType the found type
     * @param name string name (Fully-Qualified-Name or within the local namespace)
     *
     * @return [description]
     */
    protected virtual Object createFromType(Type foundType, String name) {
        Object result = null;

        if ( foundType == null && name != null ) {
            foundType = this.theObjectCollection.get( name);
        }
        // do we know what to create
        if ( foundType != null ) {
            result = foundType.newInstance();
        }

        return result;
    } // end of createFromType

    ////////////////////////////////////////////////////////////////////////////////
    /// Private Methods
    ////////////////////////////////////////////////////////////////////////////////

    /**
     * @brief initialize object values in the class that we know
     * @description Initialize what the factory knows how to create -- these are the well-known types (in the event a null is used)
     */
    private void initializeBase() {
        // set up well-known objects
        this.addToCollection(ApexConstants.LoggerResource, ApexLogger.class);
        this.addToCollection(ApexConstants.ExceptionHandler, ApexExceptionHandler.class);
        this.addToCollection(ApexConstants.ExceptionFormatter, ExceptionFormatter.class);
        this.addToCollection(ApexConstants.SendEmailChannel, ApexMailMessageSender.class);
        this.addToCollection(ApexConstants.ExceptionPolicyHandler, ApexExceptionPolicyStrategy.class);
        this.addToCollection(ApexConstants.CacheResource, ApexCache.class);
        this.addToCollection(ApexConstants.PreviousTransactionResultResource, ApexPreviousTransactionResult.class);
    } // end of initializeBase

} // end of ApexObjectFactory