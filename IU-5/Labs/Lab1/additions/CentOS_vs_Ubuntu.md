# CentOS vs. Ubuntu

### Question:
I had a web server that ran Ubuntu, but the hard drive failed recently and everything was erased. I decided to try CentOS on the machine instead of Ubuntu, since it's based on Red Hat. That association meant a lot to me because Red Hat is a commercial server product and is officially supported by my server's manufacturer. However, after a few days I'm starting to miss Ubuntu. I have trouble finding some of the packages I want in the CentOS repositories, and the third-party packages I've tried have been a hassle to deal with.

My question is, what are the advantages of using CentOS as a server over Ubuntu? CentOS is ostensibly designed for this purpose, but so far I would prefer to use a desktop edition of Ubuntu over CentOS. Are there any killer features of CentOS which make it a better server OS? Is there any reason I shouldn't switch back to Ubuntu Server or Xubuntu?

### Answer:

#### First

There are no benefits that I can discern for using CentOS (or RHEL) over Ubuntu if you are equally familiar with using both OSes.

We use RHEL and CentOS heavily at work, and it's just painful -- we're building custom packages left and right because the OS doesn't come with them, and paid RedHat support is worse than useless, being chock full of "pillars of intransigence" who see it as their duty to make sure you never get to speak to anyone who can actually answer your question. (I've heard that if you spend enough money with them their support improves markedly, so if you're a fortune 500 you'll probably have better luck than we do -- but then again, if you're fortune 500 you're probably chock full of useless oxygen thieves internally anyway, so it feels natural to deal with another bunch of them)

That much-vaunted "hardware support" pretty much always comes in the form of puke-worthy binary-only drivers and utilities that I'd prefer to avoid by almost any means necessary. Just choosing hardware that has proper support to begin with is much less hassle than trying to deal with the crap utilities.

The long-term stability of the OS platform isn't a differentiating factor -- Ubuntu has LTS (long-term support) releases that are around for five years (and which are coming out more often than RHEL releases, so if you want the latest and greatest you're not waiting as long), so there's no benefit there either.

Proprietary software doesn't get much of a benefit, either -- installing Oracle on RedHat is just as much of a "genitals in the shredder" experience as installing it on Debian, and you won't get any useful help from Oracle either (proprietary software support is near-universally worthless in my long and painful experience).

The only benefit to running CentOS is if you are more comfortable working in that environment and have your processes and tools tuned that way.

#### Second


'Enterprisey' server deployments are huge projects, with lots of inertia, and admins want to keep them running for many years with only bugfixes. Never new features without a well-rehearsed testing procedure.

For this, it's really valuable to have a slow-moving foundation. So that other big and slow-moving projects can be validated on the new version several months after release of the OS, and still you have years before it's declared obsolete.

That's what RHEL (and CentOS) provide: manufacturers can validate that it works on the hardware, big ISVs (like Oracle, for example) can test it, and then around a year after the last release of RHEL, you can use it knowing that everybody around you knows it very well. Then you install it, configure, and when it runs, it will keep running for years, without surprises. You can be (mostly) assured that when you patch it, you'll get the latest bug fixes, but not any new feature.

of course, the 'no surprises' part also implies not to update almost any part of the distribution for the whole lifetime of the release. So it's limited, and already obsolete when released (by other distro's standards).

Personally, I prefer Ubuntu's timing. It's very rare for me to have an application for more than 3-4 years without having to rebuild it (due to changing requirements), so long term stability (in the 'stagnancy' sense) isn't so crucial in most cases.
