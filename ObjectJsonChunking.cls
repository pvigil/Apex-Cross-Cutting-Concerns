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
 * Encapsulates all behaviour logic relating to the JSON Chunking
 *
 * For more guidelines and details see
 *   https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Domain_Layer
 * @group Domain Layer
 **/
public without sharing class ObjectJsonChunking {
	// default chunking size
	public static final Integer DefaultChunkSize = 100;
	private  Integer chunkingSize = DefaultChunkSize;
	/**
	 * @brief ctor
	 * @description default ctor
	 */
	public ObjectJsonChunking() {
		this(DefaultChunkSize);
	} // end of ctor
	/**
	 * @brief ctor
	 * @description ctor
	 *
	 */
	public ObjectJsonChunking(Integer chunkedSize) {
		Integer correctChunkSize = (chunkedSize < 0 || chunkedSize > DefaultChunkSize ) ? DefaultChunkSize : chunkedSize;
		this.chunkingSize = correctChunkSize;
	} // end of ctor
	/**
	 * @brief create the chunks
	 * @description check the chunks
	 *
	 * @param objs list of sobjects
	 * @param ids list of delete ids
	 * @param opsType type of operation [create/delete/update]
	 *
	 * @return array of chunks
	 */
	public  Map<Integer, String> createObjectChunks(List<SObject>objs, List<Id>ids, String opsType) {
		Map<Integer, String> chunks = new Map<Integer, String>();
		String results = '',
		       ops = opsType == null ? '' : opsType;
		Boolean isDelete = 'delete'.equalsIgnoreCase(ops);
		Integer listSize = isDelete ? ids.size() : objs.size();
		Integer numOfChunks = Math.mod( listSize, this.chunkingSize) + 1,
		        isAll = numOfChunks,
		        startChunk = 1,
		        startAt = 0,
		        endAt = this.chunkingSize;

		do {
			numOfChunks--;
			results = '';

			if (ids != null
			        && isDelete
			        && ids.size() > 0 ) {
				List<Id> returnedObj = this.chunkIdListBy(ids, startAt, endAt, isAll);
				results = JSON.serialize(returnedObj);

			} else if (!isDelete && objs.size() > 0) {
				List<SObject> returnedObj = this.chunkSObjectListBy(objs, startAt, endAt, isAll);
				results = JSON.serialize(returnedObj);
			}
			// any data serialize
			if ( results != null && results.length() > 0 ) {
				chunks.put(startChunk, results);
				startChunk++;
			}
			startAt += this.chunkingSize - 1;
			endAt += this.chunkingSize;
			if ( endAt > listSize) {
				endAt = listSize;
			}

		} while ( numOfChunks > 0);

		// Return chunks
		return chunks;

	} // end of createObjectChunks
	/**
	 * @brief chunk the sobjects
	 * @description chunk the sobjects
	 *
	 * @param s [description]
	 * @param startAt [description]
	 * @param endAt [description]
	 * @param chunk [description]
	 * @return [description]
	 */
	private List<SObject> chunkSObjectListBy(List<SObject>objs, Integer startAt, Integer endAt, Integer chunk) {
		List<SObject> newList = null;
		if ( chunk == 0 ) {
			return objs;
		}
		newList = new List<SObject>();
		for (Integer inx = startAt; inx < endAt; inx++) {
			newList.add(objs[inx]);
		}
		return newList;
	} // end of chunkSObjectListBy
	/**
	 * @brief chunk the ids
	 * @description chunkd the ids
	 *
	 * @param s [description]
	 * @param startAt [description]
	 * @param endAt [description]
	 * @param chunk [description]
	 * @return [description]
	 */
	private List<Id> chunkIdListBy(List<Id>objs, Integer startAt, Integer endAt, Integer chunk) {
		List<Id> newList = null;
		if ( chunk == 0 ) {
			return objs;
		}
		newList = new List<Id>();
		for (Integer inx = startAt; inx < endAt; inx++) {
			newList.add(objs[inx]);
		}
		return newList;
	} // end of chunkIdListBy

} // end of ObjectJsonChunking