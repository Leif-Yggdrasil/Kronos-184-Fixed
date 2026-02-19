![Kronos Logo](https://imgur.com/vlOi8YW.png)

---

**This was released on [Rune-Server](https://www.rune-server.ee/runescape-development/rs2-server/downloads/696766-kronos-osrs-semi-custom-server-deob-client-multi-world-support-184-a.html) by [Patrity](https://www.rune-server.ee/members/patrity/).**

---
**If you would like to contribute to this project, Message me on discord leif.dev**

**Updated 12/02/2026**

**I have removed Central server, Migrated social, Punishment and offline mode removed (world_stage in server.properties set to DEV achieves the same functionality), Player saving is now handled locally with Xenforo's removal, If you set the world_type to LIVE, then you can either comment out the database functionality in Server.java or setup using a Database for player saving yourself.**

**Kilim has been removed and replaced with Java's virtual threads, You will now need to run the server with JDK21 (Runelite is still Java 8, Go to Settings > Build, Execution, Deployment > Gradle and make sure both gradle projects are set properly if you run into any issues)**

**The project setup is still for the most part the same, Cache will now be loaded from the root directory, just rename server.example.properties to server.properties in both server and update server and then link runelite to Gradle project.**

---

**Gradle has been updated to 8.14, Kotlin Updated to 2.1.21, JDA to 5.5.1 and Runelite has been fixed**

---

> Kronos was a semi-custom server that was hosted from May to September of 2020. We launched with 150 players online and maintained stability well.
> Our goal was to have the features of a modern deob client such as gpu rendering while also having high quality custom content.
> This package has been collecting dust on my github repository and I'd like to have it out to the community in hopes that it may inspire some users to move away from 317 servers and into deobs even if they want to do custom servers.
> ReverendDread has already released our cache editor which was written for Kronos. That can be found [HERE](https://www.rune-server.ee/runescape-development/rs2-client/tools/695878-open-source-osrs-deob-cache-tools.html). Be sure to thank his post!
>
> Most notably is the way item attributes and upgrades work. On each item object there is also an optional list of attributes that can be added fairly easily.
> This server contains most content up to TOB and we started a good bit of work on it before closing. The interfaces and party systems are done, combat it left.
>
> You can learn more about what there server has to offer in our [advertisement thread](https://www.rune-server.ee/runescape-development/rs2-server/advertise/690549-kronos-first-osrs-deob-custom-server-just-released.html)
---

# **Setup Guide**

Step 1.
Open Kronos-master in Intellij  
![Step 1.png](SetupGuide/Step%201.png)  
![Step 2.png](SetupGuide/Step%202.png)  

Now you need to set Java in Project Structure to JDK21  
![Step 3.png](SetupGuide/Step%203.png)  
![Step 4.png](SetupGuide/Step%204.png)  

Next you will need to set Java in Settings > Build, Execution, Deployment > Build Tools > Gradle and set Kronos-master to Project SDK (If you did previous step) / JDK21  
Then runelite will need to be set to JDK8  
![Step 5.png](SetupGuide/Step%205.png)  
![Step 6.png](SetupGuide/Step%206.png)  
![Step 7.png](SetupGuide/Step%207.png)  

In the Project directory open runelite drop down right click settings.gradle.kts and link to Gradle project  
![Step 8.png](SetupGuide/Step%208.png)  

Then open the drop down for kronos-server and kronos-update-server and rename both server.example.properties to server.properties  
![Step 9.png](SetupGuide/Step%209.png)  

Your world_stage will be set to DEV within server.properties, This will give you admin rights on account creation and also doesn't verify password on login  
(This will change your password each time you login though since player saving is local it will save it each time, You can change this behaviour easily so it skips changing it though)  
If you want to go to production you will need to set world_stage to LIVE, This will then run the code in Server.java for the database, which you will need to decide yourself if you want to use it.  
Player saving is local on LIVE world_stage anyways so you can just as easily comment out the database.  

Now you have server.properties renamed you will be able to run kronos-update-server, kronos-server and OpenOSRS  
![Step 10.png](SetupGuide/Step%2010.png)  
![Step 11.png](SetupGuide/Step%2011.png)  

Enjoy!  
![Step 12.png](SetupGuide/Step%2012.png)
