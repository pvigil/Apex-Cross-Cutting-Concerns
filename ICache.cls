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
 * @brief Caching
 * @description  Caching
 * @group Common Layer 
 */
public virtual interface ICache {

    /**
     * @brief cache partition name
     * @description cache partition name
     * @return String
     */
    String partitionName();

    /**
     * @brief is cache available
     * @description is cache available
     * @return Boolean
     */
    Boolean isAvailable();

    /**
     * @brief get an item from cache
     * @description get an item from cache
     * @return Object
     */
    Object get(String name);

    /**
     * @brief item in cache
     * @description item in the cache
     * @return Boolean
     */
    Boolean contains(String name);

    /**
     * @brief get cahce keys
     * @description get cache keys
     * @return Boolean
     */
    Set<String> getKeys();

    /**
     * @brief put value into cache
     * @description put value into cache
     * @return void
     */
    void put(String key, Object value);

    /**
     * @brief put value in cache
     * @description put value into cache
     *
     * @param key String name
     * @param value object value
     * @param ttlSecstime to live in seconds (max. in 8 hrs == 28,800 secs - min is 300 secs) MAX_TTL_SECS
     */
    void put(String key, Object value, Integer ttlSecs);

    /**
     * @brief remove from cache
     * @description remove case sensitive key value from cache
     *
     * @param key case sensitive string name
     * @return Boolean true if removed
     */
    Boolean remove(String key);

} // end of ICache