---

layout: page

---

# Mirador@Stanford serves encrypted (https) content

If you want to experiment with Mirador using unencrypted content (http) you can view it in the demo site at <http://projectmirador.org/>.

Here are some sites that serve IIIF content securely. You can open IIIF content from the following sites in Mirador@Stanford:

### Copy and Paste URLs from:

[World Digital Library](https://wdl.org/)

[Digital Collections, Wayne State University ](https://digital.library.wayne.edu/) (note: add the "s" to the manifest URI)

[University of British Columbia Open Collections](https://open.library.ubc.ca/) (copy paste from “Embed.” Add the "s" to the manifest URI)

### Drag and Drop the IIIF Icon from:

[Stanford Digital Repository Images in SearchWorks](https://searchworks.stanford.edu/?f%5Bbuilding_facet%5D%5B%5D=Stanford+Digital+Repository&f%5Bformat_main_ssim%5D%5B%5D=Image)

[The Library at Wellcome Collection](https://wellcomelibrary.org/)

[Bavarian State Library](https://www.digitale-sammlungen.de/index.html)

### Discover content and construct a manifest URI:

[Internet Archive](https://archive.org/)  example: [https://iiif.archivelab.org/iiif/ ](https://iiif.archivelab.org/iiif/%5Bput)[Internet archive item id here] /manifest.json

## Why https? Some answers from others:

### *Scott Gilbert, Wired Magazine*
You wouldn’t write your username and passwords on a postcard and mail it for the world to see, so why are you doing it online? Every time you log in to Twitter, Facebook or any other service that uses a plain HTTP connection, that’s essentially what you’re doing.

There is a better way, the secure version of HTTP — HTTPS. That extra “S” in the URL means your connection is secure, and it’s much harder for anyone else to see what you’re doing. 


### *U.S. Chief Information Officer*

HTTPS is the internet’s next phase. The internet’s standards bodies, web browsers, major tech companies, and the internet community of practice have all come to understand that HTTPS should be the baseline for all web traffic.

* The W3C’s Technical Architecture Group has found that [the web should actively prefer secure connections](https://www.w3.org/2001/tag/doc/web-https) and transition entirely to HTTPS.
* The IETF has said that [pervasive monitoring is an attack](https://datatracker.ietf.org/doc/rfc7258/), and the Internet Architecture Board (the IETF’s parent organization) recommends that [new protocols use encryption by default](https://www.iab.org/2014/11/14/iab-statement-on-internet-confidentiality/).
* The Chrome and [Firefox](https://blog.mozilla.org/security/2015/04/30/deprecating-non-secure-http/) security teams are working on [gradually marking plain HTTP as non-secure](https://www.chromium.org/Home/chromium-security/marking-http-as-non-secure).

Ultimately, the goal of the internet community is to establish encryption as the norm, and to phase out unencrypted connections.


### *Google Developers*


HTTPS prevents intruders from being able to passively listen to communications between websites and users.

One common misconception about HTTPS is that the only websites that need HTTPS are those that handle sensitive communications. Every unprotected HTTP request can potentially reveal information about the behaviors and identities of your users. Although a single visit to one of your unprotected websites may seem benign, some intruders look at the aggregate browsing activities of your users to make inferences about their behaviors and intentions, and to [de-anonymize](https://en.wikipedia.org/wiki/De-anonymization) their identities. For example, employees might inadvertently disclose sensitive health conditions to their employers just by reading unprotected medical articles.

