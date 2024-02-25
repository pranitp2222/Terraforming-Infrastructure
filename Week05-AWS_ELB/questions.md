# Chapter 01 - Designing for a Distributed World

1. What is distributed computing?
   
    Answer - Distributed computing involves the construction of large-scale systems that distribute work across hundreds or thousands of machines, in contrast to traditional single-computer or client-server setups. It deals with the challenges posed by the immense scale, where millions of users generate billions of queries, and speed is crucial, with users expecting responses in milliseconds. In distributed systems, hardware failures are common, and thus, they are anticipated and designed around. Automation plays a pivotal role in tasks like software deployment, operations, and failure handling due to the sheer complexity of managing numerous machines.

2. Describe the three major composition patterns in distributed computing.

    Answer - There are three major composition patterns in distributed computing are :-
    1. Load Balancer with Multiple Backend Replicas.
    2. Server with Multiple Backends
    3. Server Tree
   
    Load Balancer with Multiple Backend Replica. In this the Requests are sent to load balancer and that get forward them to one of the several backend replicas. Backends are copies of each other and that make the same request to given request. Load Balancer constantly check the backend health and stop sending traffic to which are about to failing or failing ones.
   
    Server with Multiple Backends. In which the server processes a request by sending the queries to multiple backend servers. And then the server combines the answer from the backends to create the final reply. This patters is efficient fot parallel processing and managing latency.
    
    Server Tree. In which multiple servers are incorporate or collaborate in a structure of Tree wit root, parents and leaf all as servers. They mostly used for accessing the larger datasets in which the leaf servers stores a less data as compare to others. The root takes all the response from leaf server to get the final result.

3. What are the three patterns discussed for storing state?
   
   Answer - There are three patterns for storing states:-
   1. One machine storage - In which all the state are stored on a single machine. It is simple but limited by machine capacity and data loss if machine fails
   2. Replica and sharding - In this the states are stored in the fraction or shard distributed across multiple machine. Each shard replicate on multiple machine which provide redundancy and ensure no data loss.
   3. Root and leaf Server Pattern (Server Tree) - In this the root server receives request to store or retrieve states and determine which shard contains the relevant data.

4. Sometimes a master server does not reply with an answer but instead replies with where the answer can be found. What are the benefits of this method?
   
   Answer - There are several benefits of this methods :-
   1. Scalability like a master server can handel large number of request as it has not to manage transfer of data.
   2. Data Retrieval - In which know the location of data where is that stored so it is easy to direct go to location to data which we need.
   3. Flexibility - In this the data can be access from various machine at one time.
   4. Load balancing - In this we can directly talk with the machine which holds the data. So the load gets distributed.
   5. Fault Tolerance - because the master server is not responsible for handeling of data transfer.

5. Section 1.4 describes a distributed file system, including an example of how reading terabytes of data would work. How would writing terabytes of data work?
   
   Answer - While writing the terabytes of data in the distributed file systems. The masters server has to find the location first where the data has to be store. For this the master server need to select the location and machines which will clear the redundancy issue. Then master server will distribute the data to particular machines. There will be on addition thing master server has to do is to keep track of the location of the data store for the future operations. While the write operation each machine has to update data chunks with new data on the location.

6. Explain each component of the CAP Principle. (If you think the CAP Principle is awesome, read “The Part-Time Parliament” (Lamport & Marzullo 1998) and “Paxos Made Simple” (Lamport 2001).)

    Answer - CAP Principle components :-
    1. Consistency  - In which all the nodes in the system should see the same data at the same time regardless of which replica you are using. If there is some update operation happened in one replica among multiple replica then all the users see the update information at same time on all the replica. Systems that do not guarantee consistency may provide eventual consistency.
    2. Availability - It means that, there should be the surety of that every request has to receives a response which shows the success or failure. It means that the system is up and running. In this an available system may also report failure for example like when system are overload and reply to requests with an error code that means "try again later".
    3. Partition Tolerance - means that the system continues to operate even if arbitrary message loss or failure occurs between nodes or some parts of the system. The simplest example of partition tolerance is when the system continues to operate even if the machines involved in providing the service lose the ability to communicate with each other due to a network link going down

7. What does it mean when a system is loosely coupled? What is the advantage of these systems?
   
   Answer - The system is loosely coupled means that the components within the system have little or no knowledge of the internal working of other components. As the result subsystem can be replace by one that provide the same abstraction interface even if its implemented differently. The abstraction allows subsystem to be replace with different implementations as long as they have same abstraction.

   The advantage of loosely coupled system is that they are easier to evolve and change over time. 

8. How do we estimate how fast a system will be able to process a request such as retrieving an email message?
   
   Answer - At the start of the design process we create a multiple or many designs to estimate how fast each will be and later we will eliminate the onces that are not fast. The fastest design may not always be the most cost effective while considering factors like cost, complexity, and performance to select best suitable design. We will build the prototype to test our assumptions made during the design phase. If we are wrong, we go back to step one; at least the next iteration will be informed by what we have learned. As we build the system, we are able to remeasure and adjust the design if we discover our estimates and prototypes have not guided us as well as we had hoped.

9.  In Section 1.7 three design ideas are presented for how to process email deletion requests. Estimate how long the request will take for deleting an email message for each of the three?  Use the updated numbers from the book located at: [Numbers Every Developer Needs to know](https://colin-scott.github.io/personal_website/research/interactive_latency.html "Link to numbers every developer needs to know") - update of Figure 1.10 in the book. SHOW WORK!
    
   Answer - 

   Designed 1 -  Contact the server and delete the message from the storage system and the index.
   in this the authentication will have 3ms. Deletion from 4 disk take 10ms for one which means 40ms. Then deletion of index storage will be 2MB of 30ms that is 60 ms. So overall will be 3ms + 40ms + 60ms = 103ms.

   Designed 2 - The storage system simply mark the message as deleted in the index.
   in this the authentication will have 3ms. And after that we can see that message is deleted at index is 10ms. So total will be 3ms + 10 ms = 13 ms. This would be considerably faster but would require a new element that would reap messages marked for deletion and occasionally compact the index, removing any items marked as deleted.

   Designed 3 - Asynchronous design. In this the faster response time can be achieved. The client sends requests to the server and quickly returns control to the user without waiting for the request to complete. In this the authentication will have 3ms and the queue for the request on the server which takes minimal time that is around 5ms. So overall it is like 3ms + 5ms  = 8ms.

   