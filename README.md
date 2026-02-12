![Kronos Logo](https://imgur.com/vlOi8YW.png)

---

**This was released on [Rune-Server](https://www.rune-server.ee/runescape-development/rs2-server/downloads/696766-kronos-osrs-semi-custom-server-deob-client-multi-world-support-184-a.html) by [Patrity](https://www.rune-server.ee/members/patrity/).**

---
**Updated 12/02/2026**

**I have removed Central server, Migrated social, Punishment and offline mode removed (world_stage in server.properties set to DEV achieves the same functionality), Player saving is now handled locally with Xenforo's removal, If you set the world_type to LIVE, then you can either comment out the database functionality in Server.java or setup using a Database for player saving yourself.**

**NOTE: Passwords are not hashed, I will possibly deal with this in the future, but I didn't look into it, If someone else wants to contribute to add that / anything else, then feel free**

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
