# Exercises - Chapter 03 Selecting a Service Platform

1. Compare IaaS, PaaS, and SaaS on the basis of cost, configurability, and control (hint make a chart)
   
   Answer - ![answer](https://github.com/illinoistech-itm/ppatil19/blob/main/ITMO-544/Week07-Auto-Scaling/images/Screenshot%202023-10-10%20at%203.07.55%E2%80%AFPM.png)

2. What are the caveats to consider in adopting Software as a Service?
   
   Answer  - Many SaaS offerings are upgraded frequently and majority of time without warning, providing little opportunity for training. Users should be able to access major new releases for the purpose of planning, training, and user acceptance testing. The provider should offer a mechanism for users to select the day they will be moved to major releases, or provide two tracks: a “rapid release” track for customers that want new features without delay and a “scheduled release” track for customers that would like new features to appear on a published schedule, perhaps two to three weeks after the rapid release track. 
   
   Customers will be concerned about their ability to migrate out of the application at the end of the contract or if they are dissatisfied. We believe it is unethical to lock people into a product by making it impossible or difficult to export their data. This practice, called vendor lock-in, should be considered a “red flag” that the product is not trustworthy. The best way to demonstrate confidence in your product is to make it easy to leave. It also makes it easy for users to back up their data.

3. List the key advantages of virtual machines.
   
   Answer - The advantages of using virtual machines are as follows:
   1. Virtual Machines are fast and easy to create and destroy when task is complete such machine are called ephemeral machine. There is very little led time between when one is requested and when the virtual machine is usable. 
   2. Virtual Machine can make the computing more efficient. 
   3. Virtual machine are controlled through software so the virtualization system are programmable. We use API to create, start, stop and modify and destroy virtual machine. Which is not possible in the physical machine, which have to racked cabled via manual labour.
   4. Virtualization provides better isolation than simple multitasking. Stranded capacity can also be mitigated by running multiple servers on the same machine.
   5. Virtual machines permit isolation at the OS level.

4. Why might you choose physical over virtual machines?
   
   Answer - In case of virtual machine the CPU cores of physical machine as been shared by the VM. So for the physical machine the CPU cores are not shared so the performance of the physical machine will not gets affected. In virtual machine if there are multiple virtual machine doing high end task with more utilization so they will receive a fraction of the CPU’s attention which will led to the slower performance. 
   
   Physical servers have better performance than virtual machines because they run directly on hardware.

   Some resources are shared in an unbounded manner.if one virtual machine is generating a huge network traffic then other virtual machine will suffer. A hard drive can perform only so much disk I/O per second with the amount limited by the bandwidth from computer disk which can impact the performance of other virtual machine. While in physical machine we have control over the resource allocation. 
   
   There is one more problem in virtual machine as it is heavy weight and they run full operating system which takes lot of disk space. VM holds all the memory allocated to them even if it is not used. This problem can be solved by the physical machine as there is proper use of resource and there allocations. 

5. Which factors might make you choose private over public cloud services?
   
   Answer - In public cloud for certain data or service may cause a company to fail a compliance audit. So in the private cloud services has sufficient controls in place to ensure that this will not happen even in the failover scenario. Private cloud have greater control over the infrastructure.

   In terms of privacy, Using the public cloud means your data and code will on someone else facility. Which means that they will not have direct access to data but they will get access to that data eventually without out knowledge. So in private cloud there is the proper way to get the access to our data involves making you aware of their request. In a private cloud, the other customers are all from the same company, which may be considered an acceptable risk; the incident can be contained and not become public knowledge. In a public cloud, the exposure could be to anyone, possibly your competitors.

   In term of cost. The public cloud is cheaper then the private cloud. Having private cloud can be more cost-effective in the long run for organizations that have consistent, high-demand workloads.

   In terms of Control. A private cloud affords you more control. You can specify exactly what kind of hardware will be used, which network topology will be set up, and so on. 
