To run `scriptfile_without_loop.lua`:

    redis-cli --eval scriptfile_without_loop.lua 3 points:Above20 points:Above30 points:Below40
    


----------------------------------------------------------------------------------------------------------

Arguments to be passed :
1) users_id 
2) Installation Id
3) paging OFFSET and display_count
4) meeting filtering parameters.

POC for filtering meeting on Meeting Status and Meeting Type and apply Client Security
We will be maintaining following 6 sets/data structure in Redis

Example:


Set Name	                Set content (meetingId)
meeting_type:email_ins_10	11, 12, 15, 16, 19, 20
meeting_type:sms_ins_10 	11, 13, 15, 17, 19, 21
meeting_status:open_ins_10	11, 13, 17, 19, 23
meeting_status:close_ins_10	10, 12, 14, 16, 18, 20


Set Name	        Set content (clientId)
clients_for_user:1	7, 9, 11, 47
clients_for_user:2	1, 2, 3, 8, 10, 11
clients_for_user:3	4, 6, 8, 10, 12, 14, 16, 20, 24
clients_for_user:4	3, 6, 9, 12, 15, 18, 21, 24



HASHSET 	JSON string 	client id
meeting:11	details here	2
meeting:15	details here	7
meeting:19	details here	8
meeting:23	details here	12


AIM 1.1: To filter the meetings which are open and has meeting type email :
Example of clients sets:
We fire following command
 "meeting_type:email" ∩ "meeting_status:open". and 
We get set named as FilteredSet containing following interactionId - {11, 19}

AIM 1.2 : Applying Client Security
For user:1

Iterate through meeting ids  in FilteredSet
Get client Id from hash-set.
if client Id ∈ clients_for_user:1
Yes, Add it in the array/set

AIM 1.3 : Sort the Filtered data
Sort the data obtained according to the users requirement. If required we will sort using external keys.
To sort meeting Ids according to meeting date, we make a sorted set.
Eg:


meeting_date	element (meeting_id)	weight

                meeting:1	10062017

                meeting:5	12062017

                meeting:6	15062017

                meeting:10	16062017

                meeting:12	19062017
                
                
Now we perform :
"FilteredSet" ∩ "meeting_date"
Store the intersected set as "SortedFilteredSet".


AIM 1.4 : Limit the "SortedFilteredSet".
Limit the data as per the parameters passed i.e. paging OFFSET and display_count.


AIM 1.5 : Get details from hashset
Fetch the details from the HashSet using the meeting Ids.
